Sequel.migration do
  up do
    create_table(:character_classes) do
      primary_key :id, type: :Bignum
      String :name, null: false
    end
  end

  down do
    drop_table :character_classes
  end
end