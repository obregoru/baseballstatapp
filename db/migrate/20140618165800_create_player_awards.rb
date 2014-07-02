class CreatePlayerAwards < ActiveRecord::Migration
  def change
    create_table :player_awards do |t|
      t.integer :league_id
      t.string :award_year
      t.string :award_name
      t.integer :player_id

      t.timestamps
    end
  end
end
