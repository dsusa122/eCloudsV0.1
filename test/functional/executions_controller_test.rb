require 'test_helper'

class ExecutionsControllerTest < ActionController::TestCase
  setup do
    @execution = executions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:executions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create execution" do
    assert_difference('Execution.count') do
      post :create, execution: { application_id: @execution.application_id, description: @execution.description, directory_id: @execution.directory_id, end_date: @execution.end_date, name: @execution.name, start_date: @execution.start_date, user_id: @execution.user_id }
    end

    assert_redirected_to execution_path(assigns(:execution))
  end

  test "should show execution" do
    get :show, id: @execution
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @execution
    assert_response :success
  end

  test "should update execution" do
    put :update, id: @execution, execution: { application_id: @execution.application_id, description: @execution.description, directory_id: @execution.directory_id, end_date: @execution.end_date, name: @execution.name, start_date: @execution.start_date, user_id: @execution.user_id }
    assert_redirected_to execution_path(assigns(:execution))
  end

  test "should destroy execution" do
    assert_difference('Execution.count', -1) do
      delete :destroy, id: @execution
    end

    assert_redirected_to executions_path
  end
end
