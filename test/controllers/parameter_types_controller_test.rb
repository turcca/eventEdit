require 'test_helper'

class ParameterTypesControllerTest < ActionController::TestCase
  setup do
    @parameter_type = parameter_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parameter_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parameter_type" do
    assert_difference('ParameterType.count') do
      post :create, parameter_type: { name: @parameter_type.name }
    end

    assert_redirected_to parameter_type_path(assigns(:parameter_type))
  end

  test "should show parameter_type" do
    get :show, id: @parameter_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parameter_type
    assert_response :success
  end

  test "should update parameter_type" do
    patch :update, id: @parameter_type, parameter_type: { name: @parameter_type.name }
    assert_redirected_to parameter_type_path(assigns(:parameter_type))
  end

  test "should destroy parameter_type" do
    assert_difference('ParameterType.count', -1) do
      delete :destroy, id: @parameter_type
    end

    assert_redirected_to parameter_types_path
  end
end
