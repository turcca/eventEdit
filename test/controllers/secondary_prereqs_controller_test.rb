require 'test_helper'

class SecondaryPrereqsControllerTest < ActionController::TestCase
  setup do
    @secondary_prereq = secondary_prereqs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:secondary_prereqs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create secondary_prereq" do
    assert_difference('SecondaryPrereq.count') do
      post :create, secondary_prereq: { event_id: @secondary_prereq.event_id, prereq_id: @secondary_prereq.prereq_id }
    end

    assert_redirected_to secondary_prereq_path(assigns(:secondary_prereq))
  end

  test "should show secondary_prereq" do
    get :show, id: @secondary_prereq
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @secondary_prereq
    assert_response :success
  end

  test "should update secondary_prereq" do
    patch :update, id: @secondary_prereq, secondary_prereq: { event_id: @secondary_prereq.event_id, prereq_id: @secondary_prereq.prereq_id }
    assert_redirected_to secondary_prereq_path(assigns(:secondary_prereq))
  end

  test "should destroy secondary_prereq" do
    assert_difference('SecondaryPrereq.count', -1) do
      delete :destroy, id: @secondary_prereq
    end

    assert_redirected_to secondary_prereqs_path
  end
end
