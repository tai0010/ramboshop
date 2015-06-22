require 'test_helper'

class ZbozisControllerTest < ActionController::TestCase
  setup do
    @zbozi = zbozis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:zbozis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create zbozi" do
    assert_difference('Zbozi.count') do
      post :create, zbozi: { cena_za_kus: @zbozi.cena_za_kus, nazev: @zbozi.nazev, pocet_kusu: @zbozi.pocet_kusu, popis: @zbozi.popis }
    end

    assert_redirected_to zbozi_path(assigns(:zbozi))
  end

  test "should show zbozi" do
    get :show, id: @zbozi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @zbozi
    assert_response :success
  end

  test "should update zbozi" do
    patch :update, id: @zbozi, zbozi: { cena_za_kus: @zbozi.cena_za_kus, nazev: @zbozi.nazev, pocet_kusu: @zbozi.pocet_kusu, popis: @zbozi.popis }
    assert_redirected_to zbozi_path(assigns(:zbozi))
  end

  test "should destroy zbozi" do
    assert_difference('Zbozi.count', -1) do
      delete :destroy, id: @zbozi
    end

    assert_redirected_to zbozis_path
  end
end
