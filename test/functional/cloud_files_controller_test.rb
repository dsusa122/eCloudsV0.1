require 'test_helper'

class CloudFilesControllerTest < ActionController::TestCase
  setup do
    @cloud_file = cloud_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cloud_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cloud_file" do
    assert_difference('CloudFile.count') do
      post :create, cloud_file: { name: @cloud_file.name, type: @cloud_file.type, url: @cloud_file.url }
    end

    assert_redirected_to cloud_file_path(assigns(:cloud_file))
  end

  test "should show cloud_file" do
    get :show, id: @cloud_file
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cloud_file
    assert_response :success
  end

  test "should update cloud_file" do
    put :update, id: @cloud_file, cloud_file: { name: @cloud_file.name, type: @cloud_file.type, url: @cloud_file.url }
    assert_redirected_to cloud_file_path(assigns(:cloud_file))
  end

  test "should destroy cloud_file" do
    assert_difference('CloudFile.count', -1) do
      delete :destroy, id: @cloud_file
    end

    assert_redirected_to cloud_files_path
  end
end
