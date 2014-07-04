require 'test_helper'

class ChosenParametersControllerTest < ActionController::TestCase
  setup do
    @chosen_parameter = chosen_parameters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chosen_parameters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chosen_parameter" do
    assert_difference('ChosenParameter.count') do
      post :create, chosen_parameter: { chosen_tool_id: @chosen_parameter.chosen_tool_id, parameter_value_id: @chosen_parameter.parameter_value_id }
    end

    assert_redirected_to chosen_parameter_path(assigns(:chosen_parameter))
  end

  test "should show chosen_parameter" do
    get :show, id: @chosen_parameter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chosen_parameter
    assert_response :success
  end

  test "should update chosen_parameter" do
    patch :update, id: @chosen_parameter, chosen_parameter: { chosen_tool_id: @chosen_parameter.chosen_tool_id, parameter_value_id: @chosen_parameter.parameter_value_id }
    assert_redirected_to chosen_parameter_path(assigns(:chosen_parameter))
  end

  test "should destroy chosen_parameter" do
    assert_difference('ChosenParameter.count', -1) do
      delete :destroy, id: @chosen_parameter
    end

    assert_redirected_to chosen_parameters_path
  end
end
