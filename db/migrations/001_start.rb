Sequel.migration do
  up do
    create_table(:monsters) do
      primary_key :id, type: :Bignum
      Integer :attack, null: false
      Integer :xp_awarded, null: false
      String :attack_roll
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
      Integer :hit_die, null: false
      Integer :hit_dice, null: false, default: 1
      Integer :hit_dice_max, null: false, default: 1
      column :spell_slots, :json, default: '{"one": 0, "two": 0, "three": 0, "four": 0, "five": 0}', null: false
      column :spell_slots_max, :json, default: '{"one": 0, "two": 0, "three": 0, "four": 0, "five": 0}', null: false
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
      Integer :action, null: false, default: 1
      Integer :bonus_action, null: false, default: 1
      Integer :charisma, null: false
      Integer :constitution, null: false
      Integer :dexterity, null: false
      Integer :experience, default: 0, null: false
      Integer :hp, null: false
      Integer :hp_max, null: false
      Integer :intelligence, null: false
      Integer :level, null: false, default: 1
      Integer :failure, null: false, default: 0
      Integer :success, null: false, default: 0
      Integer :strength, null: false
      Integer :wisdom, null: false
      String :status
      TrueClass :alive, default: true, null: false
      TrueClass :unconscious, default: false, null: false
      DateTime :created_at, size: 6, null: false, default: Time.now
      DateTime :updated_at, size: 6, null: false, default: Time.now
    end

    create_table(:weapons) do
      primary_key :id, type: :Bignum
      String :name
      String :weapon_type
      String :cost
      String :damage
      String :damage_type
      String :range
      String :weight
      String :properties
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
