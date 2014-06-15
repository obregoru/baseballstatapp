class League < ActiveRecord::Base
  attr_accessible :league_name
  has_many :teams
  has_many :photos, as: :imageable
  
  validates :league_name, presence: true
end
