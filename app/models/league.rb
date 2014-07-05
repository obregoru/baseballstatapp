class League < ActiveRecord::Base
  attr_accessible :league_name
  
  has_many :teams
  has_many :photos, as: :imageable
  has_many :player_awards
  has_many :batting_stats
  
  validates :league_name, presence: true

end
