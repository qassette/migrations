# frozen_string_literal: true

require 'sequel/core'
require_relative 'lib/connection'

Sequel.extension :migration
DB = Connection.new

namespace :db do
  desc 'Prints current schema version'
  task :version do
    conn = DB.connection
    version = conn.tables.include?(:schema_info) ? conn[:schema_info].first[:version] : 0
    puts "Schema Version: #{version}"
  end

  desc 'create database'
  task :create do
    DB.connection(open_db: false) do |db|
      query = db.execute("SELECT 1 FROM pg_catalog.pg_database WHERE datname = '#{DB.database}'")
      if query == 1
        puts 'Specified database already exists'
      else
        db.execute "CREATE DATABASE #{DB.database}"
      end
    end
  end

  desc 'drop database'
  task :drop do
    DB.connection(open_db: false) do |db|
      db.execute "DROP DATABASE #{DB.database}"
    end
  end

  desc 'Perform migration up to latest migration available'
  task :migrate do
    Sequel::Migrator.run(DB.connection, 'db/migrations')
    Rake::Task['db:version'].execute
  end

  desc 'Perform rollback to specified target or full rollback as default'
  task :rollback, :target do |_t, args|
    args.with_defaults(target: 0)

    Sequel::Migrator.run(DB.connection, 'db/migrations', target: args[:target].to_i)
    Rake::Task['db:version'].execute
  end
end
