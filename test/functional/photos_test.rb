require 'test_helper'
class PhotosControllerTest <ActionController::TestCase
  
  def setup
    assert @photo=Photo.new, 'Setup'
    @photo=photos(:NewYorkYankees)
  end
  
  def teardown
    @photo=nil
  end
  
  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:photos), 'assigned @photos'
  end
  
  test 'index should render correct layout' do
    get :index
    assert_template :index
    assert_template layout: "layouts/application"
  end
  
  test 'should show photo' do
    get :show, id: @photo.id
    assert_response :success
  end
  
  test 'should create photo' do
    assert_difference('Photo.count') do
      post :create,  photo: {photo_name: 'New photo', file_name:'aab.jpg'}
    end
    assert_redirected_to photo_path(assigns(:photo)), 'Redirected to photo path'
    assert_equal 'Photo was successfully created.', flash[:notice]
  end
  
  test 'should update photo' do
    put :update, :id=>photos(:NewYorkYankees), :photo=>{:file_name=>'xyz.jpg', :photo_name=>'test'}
    assert_equal 'xyz.jpg', assigns(:photo).file_name
    
  end
  
  test 'should destroy photo' do
    assert_difference('Photo.count', -1) do
      delete :destroy, id: @photo.id
    end
    assert_redirected_to photos_path
  end
    
  test 'should route to photo' do
    assert_routing '/photos/1', {controller: "photos", action: "show", id: "1"}
  end
end