class Player < ActiveRecord::Base
  belongs_to :team
  has_many :batting_stats
  has_many :photos, as: :imageable
  has_many :player_awards
  attr_accessible :first_name, :last_name, :legacy_id, :team_id
  validates :first_name, :last_name, :team_id, presence: true
  
  def first_and_last_name
     "#{first_name} #{last_name}"
  end
end
