class ZbozisController < ApplicationController
  before_action :set_zbozi, only: [:show, :edit, :update, :destroy]
before_action :confirm_logged_in
  # GET /zbozis
  # GET /zbozis.json
  def index
    @zbozis = Zbozi.all
  end

  # GET /zbozis/1
  # GET /zbozis/1.json
  def show
  end

  # GET /zbozis/new
  def new
    @zbozi = Zbozi.new
  end

  # GET /zbozis/1/edit
  def edit
  end

  # POST /zbozis
  # POST /zbozis.json
  def create
    @zbozi = Zbozi.new(zbozi_params)

    respond_to do |format|
      if @zbozi.save
        format.html { redirect_to @zbozi, notice: 'Zbozi was successfully created.' }
        format.json { render :show, status: :created, location: @zbozi }
      else
        format.html { render :new }
        format.json { render json: @zbozi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /zbozis/1
  # PATCH/PUT /zbozis/1.json
  def update
    respond_to do |format|
      if @zbozi.update(zbozi_params)
        format.html { redirect_to @zbozi, notice: 'Zbozi was successfully updated.' }
        format.json { render :show, status: :ok, location: @zbozi }
      else
        format.html { render :edit }
        format.json { render json: @zbozi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zbozis/1
  # DELETE /zbozis/1.json
  def destroy
    @zbozi.destroy
    respond_to do |format|
      @nakup = Nakup.find(params[:nakup_id])
      @cena = 0
      if @nakup.zbozis.present?
        @nakup.zbozis.each do |z|
          @cena += z.cena_za_kus * z.pocet_kusu
        end
      end
      @nakup.update(:cena_nakupu=>@cena)
      @nakup.save
      format.html { redirect_to edit_customer_nakup_path(@nakup.customer.id,@nakup.id), notice: 'Zbozi was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zbozi
      @zbozi = Zbozi.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def zbozi_params
      params.require(:zbozi).permit(:nazev, :popis, :pocet_kusu, :cena_za_kus)
    end
end
