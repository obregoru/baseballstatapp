class CreateBattingStats < ActiveRecord::Migration
  def change
    create_table :batting_stats do |t|
      t.integer :player_id
      t.string :legacy_id
      t.integer :at_bats
      t.integer :hits
      t.integer :doubles
      t.integer :triples
      t.integer :home_runs
      t.integer :runs_batted

      t.timestamps
    end
  end
end
