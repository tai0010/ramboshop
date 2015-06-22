require 'test_helper'

class PoznamkasControllerTest < ActionController::TestCase
  setup do
    @poznamka = poznamkas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:poznamkas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poznamka" do
    assert_difference('Poznamka.count') do
      post :create, poznamka: { datum: @poznamka.datum, poznamka: @poznamka.poznamka }
    end

    assert_redirected_to poznamka_path(assigns(:poznamka))
  end

  test "should show poznamka" do
    get :show, id: @poznamka
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @poznamka
    assert_response :success
  end

  test "should update poznamka" do
    patch :update, id: @poznamka, poznamka: { datum: @poznamka.datum, poznamka: @poznamka.poznamka }
    assert_redirected_to poznamka_path(assigns(:poznamka))
  end

  test "should destroy poznamka" do
    assert_difference('Poznamka.count', -1) do
      delete :destroy, id: @poznamka
    end

    assert_redirected_to poznamkas_path
  end
end
