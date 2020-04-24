Sequel.migration do
  up do
    create_table(:spells) do
      primary_key :id, type: :Bignum
      Integer :level, null: false
      String :name, null: false
      String :casting_time, null: false
      String :description, null: false
      String :duration, null: false
      String :higher_levels
      String :range, null: false
      String :type, null: false
      String :components, null: false
    end
  end

  down do
    drop_table :spells
  end
end
