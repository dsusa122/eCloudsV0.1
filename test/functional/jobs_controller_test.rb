require 'test_helper'

class JobsControllerTest < ActionController::TestCase
  setup do
    @job = jobs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job" do
    assert_difference('Job.count') do
      post :create, job: { application_id: @job.application_id, cluster_id: @job.cluster_id, end_time: @job.end_time, inputs: @job.inputs, outputdir: @job.outputdir, parameters: @job.parameters, start_time: @job.start_time, status: @job.status, user_id: @job.user_id, virtual_machine_id: @job.virtual_machine_id, wallclock_time: @job.wallclock_time }
    end

    assert_redirected_to job_path(assigns(:job))
  end

  test "should show job" do
    get :show, id: @job
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @job
    assert_response :success
  end

  test "should update job" do
    put :update, id: @job, job: { application_id: @job.application_id, cluster_id: @job.cluster_id, end_time: @job.end_time, inputs: @job.inputs, outputdir: @job.outputdir, parameters: @job.parameters, start_time: @job.start_time, status: @job.status, user_id: @job.user_id, virtual_machine_id: @job.virtual_machine_id, wallclock_time: @job.wallclock_time }
    assert_redirected_to job_path(assigns(:job))
  end

  test "should destroy job" do
    assert_difference('Job.count', -1) do
      delete :destroy, id: @job
    end

    assert_redirected_to jobs_path
  end
end
