Sequel.migration do
  up do
    create_table(:items) do
      primary_key :id, type: :Bignum
      String :name, null: false
      String :damage
      String :healing
    end
  end

  down do
    drop_table :items
  end
end