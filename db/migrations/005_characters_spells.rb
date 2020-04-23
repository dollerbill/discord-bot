Sequel.migration do
  up do
    create_table(:character_classes_spells) do
      foreign_key :character_class_id, :character_classes, type: :Bignum
      foreign_key :spell_id, :spells, type: :Bignum
      primary_key %i[character_class_id spell_id]
    end
  end

  down do
    drop_table :character_classes_spells
  end
end
