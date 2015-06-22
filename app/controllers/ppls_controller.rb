class PplsController < ApplicationController
  before_action :set_ppl, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in
  helper_method :sort_column, :sort_direction
  autocomplete :customer, :prijmeni
  # GET /ppls
  # GET /ppls.json
  def index
    if params[:customer_id].present?
      @customer = Customer.find(params[:customer_id])
      session[:customer_id] = @customer.id
       @ppls = @customer.ppls.order(sort_column + " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
        if params[:range].present?
          start_date = Date.civil(params[:range][:"start_date(1i)"].to_i,params[:range][:"start_date(2i)"].to_i,params[:range][:"start_date(3i)"].to_i)
          end_date = Date.civil(params[:range][:"end_date(1i)"].to_i,params[:range][:"end_date(2i)"].to_i,params[:range][:"end_date(3i)"].to_i)
        else
        end
      @ppls = @ppls.date_range(start_date,end_date) if start_date.present?
      
    else
       @ppls = Ppl.order(sort_column + " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
       if params[:range].present?
          start_date = Date.civil(params[:range][:"start_date(1i)"].to_i,params[:range][:"start_date(2i)"].to_i,params[:range][:"start_date(3i)"].to_i)
          end_date = Date.civil(params[:range][:"end_date(1i)"].to_i,params[:range][:"end_date(2i)"].to_i,params[:range][:"end_date(3i)"].to_i)
        else
        end
      @ppls = @ppls.date_range(start_date,end_date) if start_date.present?
    end
   
  end

  # GET /ppls/1
  # GET /ppls/1.json
  def show
  end

  # GET /ppls/new
  def new
    @ppl = Ppl.new
    @custom = Customer.new
  end

  # GET /ppls/1/edit
  def edit
    
  end

  # POST /ppls
  # POST /ppls.json
  def create
    @ppl = Ppl.new(ppl_params)
    if params["customer_id"].present?
        Customer.find(params[:customer_id]).ppls << @ppl
    else
        if params["customer"][:customer_id].present? || !params["customer"][:customer_id].blank?   
          @ppl.customer_id = params["customer"][:customer_id]
          Customer.find(params["customer"]["customer_id"]).ppls << @ppl
        end
    end
    respond_to do |format|
      if @ppl.save
        if params[:customer_id].present?
          @customer = Customer.find(params[:customer_id])
          @customer.ppls << @ppl
          @ppl.customer = @customer
          @ppl.save
          format.html { redirect_to customer_ppls_path(@customer.id), notice: 'Ppl was successfully created.' }
        else
          format.html { redirect_to @ppl, notice: 'Ppl was successfully created.' }
        end
      else
        format.html { render :new }
        format.json { render json: @ppl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ppls/1
  # PATCH/PUT /ppls/1.json
  def update
    respond_to do |format|
      if @ppl.update(ppl_params)
        format.html { redirect_to :back, notice: 'Ppl was successfully updated.' }
        format.json { render :show, status: :ok, location: @ppl }
      else
        format.html { render :edit }
        format.json { render json: @ppl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ppls/1
  # DELETE /ppls/1.json
  def destroy
    @ppl.destroy
    respond_to do |format|
        format.html { redirect_to URI(request.referer || '').path, notice: 'Ppl was successfully destroyed.' }
        format.json { head :no_content }
    end
  end
  
  def autocomplete_customer_prijmeni
    tags = Customer.select([:prijmeni]).where("prijmeni || jmeno LIKE ?", "%#{params[:term]}%")
        result = tags.collect do |t|
          { value: t.name }
        end
        render json: result
  end
  


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ppl
         @ppl = Ppl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ppl_params
      params.require(:ppl).permit(:datum, :castka, :zaplaceno, :dobirka, :datumOdeslani, :cisloBaliku, :variabilniSymbol)
    end
    
    def sort_column
      Ppl.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
