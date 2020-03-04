Sequel.migration do
  up do
    create_table(:monsters) do
      primary_key :id, type: :Bignum
      String :name, null: false
      String :race, null: false
      String :status
      TrueClass :alive, default: true, null: false
      Integer :attack, null: false
      Integer :xp_awarded, null: false
      DateTime :created_at, size: 6, null: false, default: Time.now
      DateTime :updated_at, size: 6, null: false, default: Time.now
    end

    create_table(:players) do
      primary_key :id, type: :Bignum
      String :name, null: false
      String :user
      String :gender, null: false
      String :character_class, null: false
      String :status
      String :alignment
      String :background
      Integer :attack, null: false
      Integer :experience, default: 1, null: false
      DateTime :created_at, size: 6, null: false, default: Time.now
      DateTime :updated_at, size: 6, null: false, default: Time.now
    end

    create_table(:stats, ignore_index_errors: true) do
      primary_key :id, type: :Bignum
      Integer :level, null: false
      Integer :hp, null: false
      Integer :max_hp, null: false
      Integer :strength, null: false
      Integer :dexterity, null: false
      Integer :constitution, null: false
      Integer :intelligence, null: false
      Integer :wisdom, null: false
      Integer :charisma, null: false
      Bignum :player_id
      Bignum :monster_id
      DateTime :created_at, size: 6, null: false, default: Time.now
      DateTime :updated_at, size: 6, null: false, default: Time.now

      index [:monster_id], name: :index_stats_on_monster_id
      index [:player_id], name: :index_stats_on_player_id
    end

    create_table(:weapons) do
      primary_key :id, type: :Bignum
      column :name, :text
      Bignum :player_id
      DateTime :created_at, size: 6, null: false, default: Time.now
      DateTime :updated_at, size: 6, null: false, default: Time.now

      index [:player_id], name: :index_weapons_on_player_id
    end
  end

  down do
    drop_table :weapons
    drop_table :stats
    drop_table :monsters
    drop_table :players
  end
end
