require 'test_helper'

class PreToolAssociationsControllerTest < ActionController::TestCase
  setup do
    @pre_tool_association = pre_tool_associations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pre_tool_associations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pre_tool_association" do
    assert_difference('PreToolAssociation.count') do
      post :create, pre_tool_association: { pre_tool_id: @pre_tool_association.pre_tool_id, tool_id: @pre_tool_association.tool_id }
    end

    assert_redirected_to pre_tool_association_path(assigns(:pre_tool_association))
  end

  test "should show pre_tool_association" do
    get :show, id: @pre_tool_association
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pre_tool_association
    assert_response :success
  end

  test "should update pre_tool_association" do
    patch :update, id: @pre_tool_association, pre_tool_association: { pre_tool_id: @pre_tool_association.pre_tool_id, tool_id: @pre_tool_association.tool_id }
    assert_redirected_to pre_tool_association_path(assigns(:pre_tool_association))
  end

  test "should destroy pre_tool_association" do
    assert_difference('PreToolAssociation.count', -1) do
      delete :destroy, id: @pre_tool_association
    end

    assert_redirected_to pre_tool_associations_path
  end
end
