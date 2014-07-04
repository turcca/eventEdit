require 'test_helper'

class AdviceContentsControllerTest < ActionController::TestCase
  setup do
    @advice_content = advice_contents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:advice_contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create advice_content" do
    assert_difference('AdviceContent.count') do
      post :create, advice_content: { and: @advice_content.and, condition: @advice_content.condition, equality: @advice_content.equality, text: @advice_content.text, tool_id: @advice_content.tool_id, type: @advice_content.type, value: @advice_content.value }
    end

    assert_redirected_to advice_content_path(assigns(:advice_content))
  end

  test "should show advice_content" do
    get :show, id: @advice_content
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @advice_content
    assert_response :success
  end

  test "should update advice_content" do
    patch :update, id: @advice_content, advice_content: { and: @advice_content.and, condition: @advice_content.condition, equality: @advice_content.equality, text: @advice_content.text, tool_id: @advice_content.tool_id, type: @advice_content.type, value: @advice_content.value }
    assert_redirected_to advice_content_path(assigns(:advice_content))
  end

  test "should destroy advice_content" do
    assert_difference('AdviceContent.count', -1) do
      delete :destroy, id: @advice_content
    end

    assert_redirected_to advice_contents_path
  end
end
