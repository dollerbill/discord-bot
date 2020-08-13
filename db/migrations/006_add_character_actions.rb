Sequel.migration do
  up do
    create_table(:character_actions) do
      primary_key :id, type: :Bignum
      column :combatants, :text
      column :complete, :bool, default: false, null: false
    end
  end

  down do
    drop_table :character_actions
  end
end
