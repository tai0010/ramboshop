class UzivatelsController < ApplicationController
  before_action :set_uzivatel, only: [:show, :edit, :update, :destroy]
before_action :confirm_logged_in
  # GET /uzivatels
  # GET /uzivatels.json
  def index
    @uzivatels = Uzivatel.all
  end

  # GET /uzivatels/1
  # GET /uzivatels/1.json
  def show
  end

  # GET /uzivatels/new
  def new
    @uzivatel = Uzivatel.new
  end

  # GET /uzivatels/1/edit
  def edit
  end

  # POST /uzivatels
  # POST /uzivatels.json
  def create
    @uzivatel = Uzivatel.new(uzivatel_params)

    respond_to do |format|
      if @uzivatel.save
        format.html { redirect_to @uzivatel, notice: 'Uzivatel was successfully created.' }
        format.json { render :show, status: :created, location: @uzivatel }
      else
        format.html { render :new }
        format.json { render json: @uzivatel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uzivatels/1
  # PATCH/PUT /uzivatels/1.json
  def update
    respond_to do |format|
      if @uzivatel.update(uzivatel_params)
        format.html { redirect_to @uzivatel, notice: 'Uzivatel was successfully updated.' }
        format.json { render :show, status: :ok, location: @uzivatel }
      else
        format.html { render :edit }
        format.json { render json: @uzivatel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uzivatels/1
  # DELETE /uzivatels/1.json
  def destroy
    @uzivatel.destroy
    respond_to do |format|
      format.html { redirect_to uzivatels_url, notice: 'Uzivatel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uzivatel
      @uzivatel = Uzivatel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def uzivatel_params
      params.require(:uzivatel).permit(:login, :heslo, :email)
    end
end
