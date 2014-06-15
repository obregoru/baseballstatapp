require 'test_helper'

class TestdbsControllerTest < ActionController::TestCase
  setup do
    @testdb = testdbs(:one)
  end

  test "should get index" do
    puts 'should get index'
    get :index
    assert_response :success
    assert_not_nil assigns(:testdbs)
  end

  test "should get new" do
    puts 'should get new'
    get :new
    assert_response :success
  end

  test "should create testdb" do
    assert_difference('Testdb.count') do
      post :create, testdb: { name: @testdb.name }
    end

    assert_redirected_to testdb_path(assigns(:testdb))
  end

  test "should show testdb" do
    get :show, id: @testdb
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @testdb
    assert_response :success
  end

  test "should update testdb" do
    put :update, id: @testdb, testdb: { name: @testdb.name }
    assert_redirected_to testdb_path(assigns(:testdb))
  end

  test "should destroy testdb" do
    assert_difference('Testdb.count', -1) do
      delete :destroy, id: @testdb
    end

    assert_redirected_to testdbs_path
  end
end
