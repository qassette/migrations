# frozen_string_literal: true

# Represents sequel connection data built from env variables
class Connection
  def initialize
    @url = URI.parse ENV['DATABASE_URL']
  end

  # @param open_db [Symbol]
  # @return [Sequel::Database]
  # @yield [Sequel::Database]
  def connection(open_db: true)
    connection_parameters = to_h
    connection_parameters[:database] = database if open_db
    connected = Sequel.connect(connection_parameters)
    block_given? ? (yield connected) : connected
  end

  # @return [String]
  def database
    @url.path.sub(%r{^/}, '')
  end

  private

  # @return [Hash]
  def to_h
    {
      adapter: @url.scheme,
      host: @url.host,
      user: @url.user,
      password: @url.password
    }
  end
end
