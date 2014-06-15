class Team < ActiveRecord::Base
  belongs_to :league
  has_many :players
  has_many :photos , as: :imageable
  
  attr_accessible :league_id, :owner_name, :team_name
  
  validates :team_name, presence: true
end
