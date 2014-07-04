require 'test_helper'

class ParameterValuesControllerTest < ActionController::TestCase
  setup do
    @parameter_value = parameter_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parameter_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parameter_value" do
    assert_difference('ParameterValue.count') do
      post :create, parameter_value: { name: @parameter_value.name, parameter_type_id: @parameter_value.parameter_type_id }
    end

    assert_redirected_to parameter_value_path(assigns(:parameter_value))
  end

  test "should show parameter_value" do
    get :show, id: @parameter_value
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parameter_value
    assert_response :success
  end

  test "should update parameter_value" do
    patch :update, id: @parameter_value, parameter_value: { name: @parameter_value.name, parameter_type_id: @parameter_value.parameter_type_id }
    assert_redirected_to parameter_value_path(assigns(:parameter_value))
  end

  test "should destroy parameter_value" do
    assert_difference('ParameterValue.count', -1) do
      delete :destroy, id: @parameter_value
    end

    assert_redirected_to parameter_values_path
  end
end
