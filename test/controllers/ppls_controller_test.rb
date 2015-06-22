require 'test_helper'

class PplsControllerTest < ActionController::TestCase
  setup do
    @ppl = ppls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ppls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ppl" do
    assert_difference('Ppl.count') do
      post :create, ppl: { castka: @ppl.castka, cisloBaliku: @ppl.cisloBaliku, datum: @ppl.datum, datumOdeslani: @ppl.datumOdeslani, dobirka: @ppl.dobirka, variabilniSymbol: @ppl.variabilniSymbol, zaplaceno: @ppl.zaplaceno }
    end

    assert_redirected_to ppl_path(assigns(:ppl))
  end

  test "should show ppl" do
    get :show, id: @ppl
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ppl
    assert_response :success
  end

  test "should update ppl" do
    patch :update, id: @ppl, ppl: { castka: @ppl.castka, cisloBaliku: @ppl.cisloBaliku, datum: @ppl.datum, datumOdeslani: @ppl.datumOdeslani, dobirka: @ppl.dobirka, variabilniSymbol: @ppl.variabilniSymbol, zaplaceno: @ppl.zaplaceno }
    assert_redirected_to ppl_path(assigns(:ppl))
  end

  test "should destroy ppl" do
    assert_difference('Ppl.count', -1) do
      delete :destroy, id: @ppl
    end

    assert_redirected_to ppls_path
  end
end
