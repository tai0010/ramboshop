class PoznamkasController < ApplicationController
  before_action :set_poznamka, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in
  helper_method :sort_column, :sort_direction
  # GET /dluhs
  # GET /dluhs.json
  def index
    if params[:customer_id].present?
      @customer = Customer.find(params[:customer_id])
      session[:customer_id] = @customer.id
      @poznamkas = @customer.poznamkas.order("created_at desc").order(sort_column + " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
    else
      @poznamkas = Poznamka.order(sort_column + " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
    end
  end

  # GET /dluhs/1
  # GET /dluhs/1.json
  def show
  end

  # GET /dluhs/new
  def new
    @poznamka = Poznamka.new
  end

  # GET /dluhs/1/edit
  def edit
  end

  # POST /dluhs
  # POST /dluhs.json
  def create
    @poznamka = Poznamka.new(poznamka_params)
    @customer = Customer.find(session[:customer_id])
    @poznamka.customer = @customer
    respond_to do |format|
      if @poznamka.save
        @customer.poznamkas << @poznamka
        if params[:customer_id].present?
          format.html { redirect_to customer_poznamkas_path(@customer.id), notice: 'Poznamka was successfully created.' }
        else
          format.html { redirect_to customer_poznamkas_path(@customer.id), notice: 'Poznamka was successfully created.' }
        end
      else
        format.html { render :new }
        
      end
    end
  end

  # PATCH/PUT /dluhs/1
  # PATCH/PUT /dluhs/1.json
  def update
    respond_to do |format|
      @customer = Customer.find(session[:customer_id])
      if @poznamka.update(poznamka_params)
        if params[:customer_id].present?
          format.html { redirect_to customer_poznamka_path(@customer.id,@poznamka.id), notice: 'Poznamka was successfully updated.' }
          format.json { render :show, status: :ok, location: @poznamka }
        else
          format.html { redirect_to poznamka_path(@poznamka.id), notice: 'Poznamka was successfully updated.' }
        end
      else
        format.html { render :edit }
        format.json { render json: @poznamka.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dluhs/1
  # DELETE /dluhs/1.json
  def destroy
    @customer = Customer.find(session[:customer_id])
    @poznamka.destroy
    respond_to do |format|
      
        format.html { redirect_to URI(request.referer || '').path, notice: 'Poznamka was successfully destroyed.' }
        format.json { head :no_content }
    
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poznamka
      @poznamka = Poznamka.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poznamka_params
      params.require(:poznamka).permit(:datum, :poznamka)
    end
    
    def sort_column
      Poznamka.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
