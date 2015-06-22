class CustomersController < ApplicationController
  before_action :set_customer, only: [:show,:edit, :update, :destroy]
  before_action :confirm_logged_in
  helper_method :sort_column, :sort_direction

  # GET /customers
  # GET /customers.json
  def index
    priority = ["modra","cervena","orange","magenta","white"]
    hodnoceni = [5,4,3,2,1]
    Customer.all.each  do |a|
      a.kontroladata
    end
    @customers = Customer.select(:id,:jmeno,:prijmeni,:mobcislo,:odpoved,:datumkontaktu,:kontaktovan,:barva).order(sort_column + " " + sort_direction)
    
    if params[:range].present? && (params["datum"]["check"] == "1")
      start_date = Date.civil(params[:range][:"start_date(1i)"].to_i,params[:range][:"start_date(2i)"].to_i,params[:range][:"start_date(3i)"].to_i)
      end_date = Date.civil(params[:range][:"end_date(1i)"].to_i,params[:range][:"end_date(2i)"].to_i,params[:range][:"end_date(3i)"].to_i)
    else
    end
    @customers = @customers.date_range(start_date,end_date) if start_date.present?
    @customers = @customers.search(params["search"]["word"]) if params["search"]["word"].present? if params["search"].present?
   #@customers = @customers.mysearch(params["search"]["word"]) if params["search"]["word"].present? if params["search"].present?
    if params["barvy"].present? && params["barvy"]["check"] == "1"
      if params["cervena"]["check"] == "1"
        @customers = @customers.where(:barva=>"cervena")
      end
      if params["modra"]["check"] == "1"
        @customers = @customers.where(:barva=>"modra")
      end
      if params["oranzova"]["check"] == "1"
        @customers = @customers.where(:barva=>"orange")
      end
       if params["ruzova"]["check"] == "1"
        @customers = @customers.where(:barva=>"magenta")
      end
       if params["bila"]["check"] == "1"
        @customers = @customers.where(:barva=>"white")
      end
      @customers = @customers.sort_by { |u| hodnoceni.index(u.rating.rating) || hodnoceni.size }
      @customers = @customers.sort_by { |u| priority.index(u.barva) || priority.size }
      @customers = Kaminari.paginate_array(@customers).page(params[:page]).per(25)
    else
      @customers = @customers.sort_by { |u| hodnoceni.index(u.rating.rating) || hodnoceni.size }
      @customers = @customers.sort_by { |u| priority.index(u.barva) || priority.size }
      @customers = Kaminari.paginate_array(@customers).page(params[:page]).per(25)
    end
     a = DateTime.now -15.day
    b = DateTime.now - 29.days
    @customers_to_contact = Customer.select(:id,:jmeno,:prijmeni,:kontaktovan,:datumkontaktu,:odpoved,:barva).where(:datumkontaktu=>b..a).order("datumkontaktu asc") #jeste nejak smysluplne seradit
    
    if params[:page].present?
      @count = (params[:page].to_i-1)*25 
    else
      @count = 0
    end
  end
  
  def changeRating
    Customer.find(params["customer_id"]).rating.update(:rating=>params["group-3"].to_i)
    redirect_to :back
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
    
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    @customer.barva = "bila"
    respond_to do |format|
      if @customer.save
        if params["poznamka"].present? && params["poznamka"]["poznamka"].present?
          
          a = Poznamka.create(:datum=>@customer.created_at, :poznamka=>params["poznamka"]["poznamka"],:customer_id=>@customer.id)
          a.save
          @customer.poznamkas << a
        end
          rating = Rating.create(:customer_id=>@customer.id,:rating=>0)
          rating.save
          @customer.rating = rating
          
        if params["star1"].present?
          @customer.rating.update(:rating=>1)
        end
        if params["star2"].present?
          @customer.rating.update(:rating=>2)
        end
        if params['star3'].present?
          @customer.rating.update(:rating=>3)
        end
        if params["star4"].present?
          @customer.rating.update(:rating=>4)
        end
        if params["star5"].present?
          @customer.rating.update(:rating=>5)
        end
        format.html { redirect_to customers_url, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end
    
  def createfromppls
    @customer = Customer.new(customer_params)
    @customer.barva = "bila"
    respond_to do |format|
      if @customer.save
        if params["poznamka"].present? && !params["poznamka"]["poznamka"] == ""
        a = Poznamka.create(:datum=>@customer.created_at, :poznamka=>params["poznamka"]["poznamka"],:customer_id=>@customer.id)
          a.save
          @customer.poznamkas << a
        end
          rating = Rating.create(:customer_id=>@customer.id,:rating=>0)
          rating.save
          @customer.rating = rating
          
        if params["star1"].present?
          @customer.rating.update(:rating=>1)
        end
        if params["star2"].present?
          @customer.rating.update(:rating=>2)
        end
        if params['star3'].present?
          @customer.rating.update(:rating=>3)
        end
        if params["star4"].present?
          @customer.rating.update(:rating=>4)
        end
        if params["star5"].present?
          @customer.rating.update(:rating=>5)
        end
        format.html { redirect_to :controller=>'ppls', :action=>'new'} #notice: 'Customer was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      @hodnoceni =  @customer.rating.rating
      if @customer.update(customer_params)
        if params["star1"].present?
          
        @customer.rating.update(:rating=>1) if @hodnoceni != 1
      end
      if params["star2"].present?
        @customer.rating.update(:rating=>2) if @hodnoceni != 2
      end
      if params['star3'].present?
        @customer.rating.update(:rating=>3) if @hodnoceni != 3
      end
      if params["star4"].present?
        @customer.rating.update(:rating=>4) if @hodnoceni != 4
      end
      if params["star5"].present?
        @customer.rating.update(:rating=>5) if @hodnoceni != 5
      end
      
        format.html { redirect_to customers_url, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:jmeno, :prijmeni, :adresa, :mesto, :psc, :mobcislo, :datumkontaktu, :email, :kontaktovan, :odpoved)
    end
    
    def sort_column
      Customer.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
