require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  
  should belong_to :imageable
  
  should validate_presence_of(:photo_name)
  should validate_presence_of(:file_name)
  
  should_not allow_mass_assignment_of(:created_at)
  should_not allow_mass_assignment_of(:updated_at)
  
  test 'create a photo record' do
    photo = Photo.new
    refute photo.save
  end
  
  test 'cannot save without a photo name' do
    photo=Photo.new
    photo.photo_name='Photo Name'
    refute photo.save
  end

  test 'cannot save photo without a file name' do
    photo = Photo.new
    photo.photo_name = 'Photo Name'
    
  end
  
  test 'update photo' do
    photo=Photo.find(2)
    photo.photo_name = 'Bobby'
    assert photo.save, 'Updated photo name to Bobby'
  end
  
  test 'destroy photo' do
    photo=Photo.find(1)
    assert photo.destroy
    assert_equal 3, Photo.count
  end
  
  
  
end