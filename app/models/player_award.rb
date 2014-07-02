class PlayerAward < ActiveRecord::Base
  belongs_to :league
  belongs_to :player
  
  validates :award_name, presence: true
  validates :award_year, 
            presence: true, 
            numericality: { only_integer: true, greater_than_or_equal_to: 1900, less_than_or_equal_to: Date.today.year },
            format: {
              with:  /(19|20)\d{2}/i,
              message: "should be a four-digit year"
            }
            
  attr_accessible :award_name, :award_year, :league_id, :player_id

  
end
