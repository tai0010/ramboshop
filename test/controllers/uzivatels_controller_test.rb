require 'test_helper'

class UzivatelsControllerTest < ActionController::TestCase
  setup do
    @uzivatel = uzivatels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:uzivatels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create uzivatel" do
    assert_difference('Uzivatel.count') do
      post :create, uzivatel: { heslo: @uzivatel.heslo, login: @uzivatel.login }
    end

    assert_redirected_to uzivatel_path(assigns(:uzivatel))
  end

  test "should show uzivatel" do
    get :show, id: @uzivatel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @uzivatel
    assert_response :success
  end

  test "should update uzivatel" do
    patch :update, id: @uzivatel, uzivatel: { heslo: @uzivatel.heslo, login: @uzivatel.login }
    assert_redirected_to uzivatel_path(assigns(:uzivatel))
  end

  test "should destroy uzivatel" do
    assert_difference('Uzivatel.count', -1) do
      delete :destroy, id: @uzivatel
    end

    assert_redirected_to uzivatels_path
  end
end
