Sequel.migration do
  up do
    # run 'CREATE EXTENSION hstore'
    create_table(:spells) do
      primary_key :id, type: :Bignum
      String :name, null: false
      String :casting_time, null: false
      String :description, null: false
      String :duration, null: false
      String :higher_levels
      String :level, null: false
      String :range, null: false
      String :school, null: false
      String :type, null: false
      TrueClass :ritual, null: false
      column :components, 'hstore'
      column :classes, 'text[]'
      column :tags, 'text[]'
    end
  end

  down do
    drop_table :spells
  end
end
