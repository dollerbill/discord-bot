Sequel.migration do
  up do
    create_table(:monsters) do
      primary_key :id, type: :Bignum
      Integer :attack, null: false
      Integer :xp_awarded, null: false
      String :race, null: false
      Bignum :stat_id
      DateTime :created_at, size: 6, null: false, default: Time.now
      DateTime :updated_at, size: 6, null: false, default: Time.now

      index [:stat_id], name: :index_monsters_on_stat_id
    end

    create_table(:players) do
      primary_key :id, type: :Bignum
      String :alignment
      String :background
      String :character_class, null: false
      String :gender, null: false
      String :name, null: false
      String :user
      Bignum :stat_id
      Bignum :weapon_id
      DateTime :created_at, size: 6, null: false, default: Time.now
      DateTime :updated_at, size: 6, null: false, default: Time.now

      index [:stat_id], name: :index_players_on_stat_id
      index [:weapon_id], name: :index_players_on_weapon_id
    end

    create_table(:stats, ignore_index_errors: true) do
      primary_key :id, type: :Bignum
      Integer :armor_class
      Integer :charisma, null: false
      Integer :constitution, null: false
      Integer :dexterity, null: false
      Integer :experience, default: 1, null: false
      Integer :hp, null: false
      Integer :intelligence, null: false
      Integer :level, null: false
      Integer :max_hp, null: false
      Integer :strength, null: false
      Integer :wisdom, null: false
      String :status
      TrueClass :alive, default: true, null: false
      DateTime :created_at, size: 6, null: false, default: Time.now
      DateTime :updated_at, size: 6, null: false, default: Time.now
    end

    create_table(:weapons) do
      primary_key :id, type: :Bignum
      Integer :attack
      String :attack_roll
      String :name
      String :type
      DateTime :created_at, size: 6, null: false, default: Time.now
      DateTime :updated_at, size: 6, null: false, default: Time.now
    end
  end

  down do
    drop_table :weapons
    drop_table :stats
    drop_table :monsters
    drop_table :players
  end
end
