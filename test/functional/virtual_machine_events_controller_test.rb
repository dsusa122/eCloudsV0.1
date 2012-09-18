require 'test_helper'

class VirtualMachineEventsControllerTest < ActionController::TestCase
  setup do
    @virtual_machine_event = virtual_machine_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:virtual_machine_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create virtual_machine_event" do
    assert_difference('VirtualMachineEvent.count') do
      post :create, virtual_machine_event: { action: @virtual_machine_event.action, event_date: @virtual_machine_event.event_date, user_id: @virtual_machine_event.user_id, vm_id: @virtual_machine_event.vm_id }
    end

    assert_redirected_to virtual_machine_event_path(assigns(:virtual_machine_event))
  end

  test "should show virtual_machine_event" do
    get :show, id: @virtual_machine_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @virtual_machine_event
    assert_response :success
  end

  test "should update virtual_machine_event" do
    put :update, id: @virtual_machine_event, virtual_machine_event: { action: @virtual_machine_event.action, event_date: @virtual_machine_event.event_date, user_id: @virtual_machine_event.user_id, vm_id: @virtual_machine_event.vm_id }
    assert_redirected_to virtual_machine_event_path(assigns(:virtual_machine_event))
  end

  test "should destroy virtual_machine_event" do
    assert_difference('VirtualMachineEvent.count', -1) do
      delete :destroy, id: @virtual_machine_event
    end

    assert_redirected_to virtual_machine_events_path
  end
end
