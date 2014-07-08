require 'test_helper'

class PolymorphicPhotoTest<ActionDispatch::IntegrationTest
fixtures  :leagues, :teams, :photos

  test 'create poloymorphic league picture' do
    league=League.find(1)
    assert league.photos.create(:file_name=>'allogo3.jpg', :photo_name=>'American League Logo (small)')
    league_photo=League.includes(:photos).where(:id=>1).last
    assert_equal 'allogo3.jpg',league_photo.photos.last.file_name
  end

  test 'retrieve poloymorphic photo object' do
    league_photo=League.includes(:photos).where(:id=>1).first
    assert_equal 'amlogo.jpg', league_photo.photos.last.file_name
  end
  
  test 'create polomorphic team picture' do
    team=Team.find(1)
    assert team.photos.create(:file_name=>'nyyankees1.jpg', :photo_name=>'2012 New York Yankees')
    team_photo = Team.includes(:photos).where(:id=>1).last
    assert_equal 'nyyankees1.jpg', team_photo.photos.last.file_name
  end 

 
    
end