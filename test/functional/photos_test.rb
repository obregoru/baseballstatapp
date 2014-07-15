require 'test_helper'
class PhotosControllerTest <ActionController::TestCase
  fixtures :users
  def setup
    assert @photo=Photo.new, 'Setup'
    @photo=photos(:NewYorkYankees)
    @user = users(:Ruben)  #User.first
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
    sign_in @user
    assert_difference('Photo.count') do
      post :create,  photo: {photo_name: 'New photo', file_name:'aab.jpg',imageable_id: 1, imageable_type:"Leagues"}
    end
    assert_redirected_to '/leagues/1', 'Redirected to parent league path'
    assert_equal 'Photo was successfully created.', flash[:notice]
    sign_out @user
  end
  
  test 'should not create photo - not authenticated' do
    post :create,  photo: {photo_name: 'New photo', file_name:'aab.jpg',imageable_id: 1, imageable_type:"Leagues"}
    assert_redirected_to user_session_path, 'Redirected to sign_in path'
 
  end
  
  test 'should update photo' do
    sign_in @user
    put :update, :id=>photos(:NewYorkYankees), :photo=>{:file_name=>'xyz.jpg', :photo_name=>'test'}
    assert_equal 'xyz.jpg', assigns(:photo).file_name
    sign_out @user
  end

  test 'should not update photo - not authenticated' do
    put :update, :id=>photos(:NewYorkYankees), :photo=>{:file_name=>'xyz.jpg', :photo_name=>'test'}
    assert_redirected_to user_session_path, 'Redirected to sign_in path'
  end
  
  test 'should destroy photo' do
    sign_in @user
    assert_difference('Photo.count', -1) do
      delete :destroy, id: @photo.id
    end
    assert_redirected_to photos_path
    sign_out @user
  end
    
  test 'should not destroy photo - not authenticated' do
    delete :destroy, id: @photo.id
    assert_redirected_to user_session_path, 'Redirected to sign_in'
  end
        
    
  test 'should route to photo' do
    assert_routing '/photos/1', {controller: "photos", action: "show", id: "1"}
  end
end