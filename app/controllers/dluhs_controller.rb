class DluhsController < ApplicationController
  before_action :set_dluh, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in
  helper_method :sort_column, :sort_direction
  # GET /dluhs
  # GET /dluhs.json
  def index
    if params[:customer_id].present?
      @customer = Customer.find(params[:customer_id])
      session[:customer_id] = @customer.id
      @dluhs = @customer.dluhs.order("created_at desc").order(sort_column + " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
    else
      @dluhs = Dluh.order(sort_column + " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
    end
  end

  # GET /dluhs/1
  # GET /dluhs/1.json
  def show
  end

  # GET /dluhs/new
  def new
    @dluh = Dluh.new
  end

  # GET /dluhs/1/edit
  def edit
  end

  # POST /dluhs
  # POST /dluhs.json
  def create
    @dluh = Dluh.new(dluh_params)
    @customer = Customer.find(session[:customer_id])
    @dluh.customer = @customer
    respond_to do |format|
      if @dluh.save
        @customer.dluhs << @dluh
        if params[:customer_id].present?
          format.html { redirect_to customer_dluhs_path(@customer.id), notice: 'Dluh was successfully created.' }
        else
          format.html { redirect_to dluhs_path, notice: 'Dluh was successfully created.' }
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
      if @dluh.update(dluh_params)
        if params[:customer_id].present?
          format.html { redirect_to customer_dluh_path(@customer.id,@dluh.id), notice: 'Dluh was successfully updated.' }
          format.json { render :show, status: :ok, location: @dluh }
        else
          format.html { redirect_to dluh_path(@dluh.id), notice: 'Dluh was successfully updated.' }
        end
      else
        format.html { render :edit }
        format.json { render json: @dluh.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dluhs/1
  # DELETE /dluhs/1.json
  def destroy
    @customer = Customer.find(session[:customer_id])
    @dluh.destroy
    respond_to do |format|
      if params[:customer_id].present?
        format.html { redirect_to customer_dluhs_path(@customer.id), notice: 'Dluh was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to dluhs_path, notice: 'Dluh was successfully destroyed.' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dluh
      @dluh = Dluh.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dluh_params
      params.require(:dluh).permit(:dluh, :poznamka,:active)
    end
    
    def sort_column
      Dluh.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
