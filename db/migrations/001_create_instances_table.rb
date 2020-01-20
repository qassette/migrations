# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:server_instances) do
      primary_key :id
      String :name
      String :uid, null: false
      Jsonb :metadata
    end

    add_index :server_instances, :uid, unique: true
  end

  down do
    drop_table(:server_instances)
  end
end
