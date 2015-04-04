require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @admin = users(:carlos)
    @group = groups(:english)
    @group_admin = users(:michael)
    @other_group = groups(:spanish)
    @other_group_admin = users(:miguel)
    @user = users(:peter)
    @other_user = users(:pedro)
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to new_user_session_url
  end

  test "should redirect show when not logged in" do
    get :show, id: @group
    assert_redirected_to new_user_session_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Group.count' do
      delete :destroy, id: @group
    end
    assert_redirected_to new_user_session_url
  end

  test "should get index when logged in" do
    sign_in @admin
    get :index
    assert_response :success

    sign_in @group_admin
    get :index
    assert_response :success

    sign_in @user
    get :index
    assert_response :success
  end

  test "should get show when logged in" do
    sign_in @admin
    get :show, id: @group
    assert_response :success

    sign_in @group_admin
    get :show, id: @group
    assert_response :success

    sign_in @user
    get :show, id: @group
    assert_response :success
  end

  test "should raise destroy when not allowed" do
    sign_in @group_admin
    assert_raise CanCan::AccessDenied do
      delete :destroy, id: @group
    end

    sign_in @other_group_admin
    assert_raise CanCan::AccessDenied do
      delete :destroy, id: @group
    end

    sign_in @user
    assert_raise CanCan::AccessDenied do
      delete :destroy, id: @group
    end

    sign_in @other_user
    assert_raise CanCan::AccessDenied do
      delete :destroy, id: @group
    end
  end

  test "should redirect destroy when admin logged in" do
    sign_in @admin
    assert_difference 'Group.count', -1 do
      delete :destroy, id: @group
    end
    assert_redirected_to groups_url
  end
end
