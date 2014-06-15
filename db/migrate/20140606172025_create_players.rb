class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :team_id
      t.string :legacy_id
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
