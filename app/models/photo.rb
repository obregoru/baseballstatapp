class Photo < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  attr_accessible :file_name, :imageable_id, :imageable_type, :photo_name
  
  validates :photo_name, :file_name, presence: true
end
