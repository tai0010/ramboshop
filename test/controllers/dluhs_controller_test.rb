require 'test_helper'

class DluhsControllerTest < ActionController::TestCase
  setup do
    @dluh = dluhs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dluhs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dluh" do
    assert_difference('Dluh.count') do
      post :create, dluh: { dluh: @dluh.dluh, poznamka: @dluh.poznamka }
    end

    assert_redirected_to dluh_path(assigns(:dluh))
  end

  test "should show dluh" do
    get :show, id: @dluh
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dluh
    assert_response :success
  end

  test "should update dluh" do
    patch :update, id: @dluh, dluh: { dluh: @dluh.dluh, poznamka: @dluh.poznamka }
    assert_redirected_to dluh_path(assigns(:dluh))
  end

  test "should destroy dluh" do
    assert_difference('Dluh.count', -1) do
      delete :destroy, id: @dluh
    end

    assert_redirected_to dluhs_path
  end
end
