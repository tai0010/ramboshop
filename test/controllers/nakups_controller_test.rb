require 'test_helper'

class NakupsControllerTest < ActionController::TestCase
  setup do
    @nakup = nakups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nakups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nakup" do
    assert_difference('Nakup.count') do
      post :create, nakup: { cena_nakupu: @nakup.cena_nakupu, datum_nakupu: @nakup.datum_nakupu, planovanynakup: @nakup.planovanynakup }
    end

    assert_redirected_to nakup_path(assigns(:nakup))
  end

  test "should show nakup" do
    get :show, id: @nakup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nakup
    assert_response :success
  end

  test "should update nakup" do
    patch :update, id: @nakup, nakup: { cena_nakupu: @nakup.cena_nakupu, datum_nakupu: @nakup.datum_nakupu, planovanynakup: @nakup.planovanynakup }
    assert_redirected_to nakup_path(assigns(:nakup))
  end

  test "should destroy nakup" do
    assert_difference('Nakup.count', -1) do
      delete :destroy, id: @nakup
    end

    assert_redirected_to nakups_path
  end
end
