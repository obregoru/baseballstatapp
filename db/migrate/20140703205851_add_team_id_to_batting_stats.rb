class AddTeamIdToBattingStats < ActiveRecord::Migration
  def change
    add_column :batting_stats, :team_id, :integer
  end
end
