require 'test_helper'

class ContentsControllerTest < ActionController::TestCase
  setup do
    @content = contents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create content" do
    assert_difference('Content.count') do
      post :create, content: { ancestry: @content.ancestry, andor: @content.andor, condition: @content.condition, equality1: @content.equality1, equality2: @content.equality2, event_id: @content.event_id, skill1: @content.skill1, skill2: @content.skill2, text: @content.text, tool1: @content.tool1, tool2: @content.tool2, type: @content.type }
    end

    assert_redirected_to content_path(assigns(:content))
  end

  test "should show content" do
    get :show, id: @content
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @content
    assert_response :success
  end

  test "should update content" do
    patch :update, id: @content, content: { ancestry: @content.ancestry, andor: @content.andor, condition: @content.condition, equality1: @content.equality1, equality2: @content.equality2, event_id: @content.event_id, skill1: @content.skill1, skill2: @content.skill2, text: @content.text, tool1: @content.tool1, tool2: @content.tool2, type: @content.type }
    assert_redirected_to content_path(assigns(:content))
  end

  test "should destroy content" do
    assert_difference('Content.count', -1) do
      delete :destroy, id: @content
    end

    assert_redirected_to contents_path
  end
end
