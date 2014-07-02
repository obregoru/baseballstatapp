class AddStatsToBattingStats < ActiveRecord::Migration
  def change
    add_column :batting_stats, :batting_year, :integer
    add_column :batting_stats, :league_id, :integer
    add_column :batting_stats, :batting_average, :decimal, :precision => 3, :scale => 2
    add_column :batting_stats, :slugging_percentage, :decimal, :precision => 3, :scale => 2
  end
end
