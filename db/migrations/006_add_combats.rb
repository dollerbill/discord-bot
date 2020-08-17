Sequel.migration do
  up do
    create_table(:combats) do
      primary_key :id, type: :Bignum
      column :combatants, :text
      column :complete, :bool, default: false, null: false
    end
  end

  down do
    drop_table :combats
  end
end
