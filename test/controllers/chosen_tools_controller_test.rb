require 'test_helper'

class ChosenToolsControllerTest < ActionController::TestCase
  setup do
    @chosen_tool = chosen_tools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chosen_tools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chosen_tool" do
    assert_difference('ChosenTool.count') do
      post :create, chosen_tool: { pre_tool_id: @chosen_tool.pre_tool_id, tool_id: @chosen_tool.tool_id }
    end

    assert_redirected_to chosen_tool_path(assigns(:chosen_tool))
  end

  test "should show chosen_tool" do
    get :show, id: @chosen_tool
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chosen_tool
    assert_response :success
  end

  test "should update chosen_tool" do
    patch :update, id: @chosen_tool, chosen_tool: { pre_tool_id: @chosen_tool.pre_tool_id, tool_id: @chosen_tool.tool_id }
    assert_redirected_to chosen_tool_path(assigns(:chosen_tool))
  end

  test "should destroy chosen_tool" do
    assert_difference('ChosenTool.count', -1) do
      delete :destroy, id: @chosen_tool
    end

    assert_redirected_to chosen_tools_path
  end
end
