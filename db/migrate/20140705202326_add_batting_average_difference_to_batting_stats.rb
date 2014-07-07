class AddBattingAverageDifferenceToBattingStats < ActiveRecord::Migration
  def change
    add_column :batting_stats, :batting_average_difference, :decimal, :precision => 3, :scale => 2
  end
end
