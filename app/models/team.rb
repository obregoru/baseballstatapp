class Team < ActiveRecord::Base
  belongs_to :league
  has_many :players
  has_many :photos , as: :imageable
  has_many :batting_stats
  
  attr_accessible :league_id, :owner_name, :team_name, :notes
  
  validates :team_name, :league_id, presence: true
end
