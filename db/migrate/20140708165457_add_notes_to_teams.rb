class AddNotesToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :notes, :text
  end
end
