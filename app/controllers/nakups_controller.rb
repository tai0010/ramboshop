class NakupsController < ApplicationController
  before_action :set_nakup, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in
  helper_method :sort_column, :sort_direction
  # GET /nakups
  # GET /nakups.json
  def index
    if params[:customer_id].present?
      @customer = Customer.find(params[:customer_id])
      session[:customer_id] = @customer.id
      @nakups = @customer.nakups.order(sort_column + " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
    else
      @nakups = Nakup.order(sort_column + " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
    end

  end

  # GET /nakups/1
  # GET /nakups/1.json
  def show
  end

  # GET /nakups/new
  def new
    @nakup = Nakup.new
    @zbozi = Zbozi.new
     @cart = session[:cart]
     if @cart.present?
       products_ids = @cart.map {|a,b| a["id"].to_i}
       @currentZbozis = Zbozi.find(products_ids)
     else
       @currentZbozis
     end
    @cena = 0
    if @currentZbozis.present?
      @currentZbozis.each do |a|
        @cena += a.pocet_kusu * a.cena_za_kus
      end
    end
  end

  # GET /nakups/1/edit
  def edit
  end

  # POST /nakups
  # POST /nakups.json
  def create
      @nakup = Nakup.new(nakup_params)
      @nakup.customer_id = params[:customer_id]
      if params["customer_id"].present?
        Customer.find(params[:customer_id]).nakups << @nakup
      else
        if params["customer"][:customer_id].present? || !params["customer"][:customer_id].blank?   
          @nakup.customer_id = params["customer"][:customer_id]
          Customer.find(params["customer"]["customer_id"]).nakups << @nakup
        end
      end
      respond_to do |format|
        if @nakup.save
          @cart = session["cart"]
          @zbozis = Zbozi.where(:id=>@cart.map{|a,b| a["id"].to_i})
          @nakup.zbozis << @zbozis
          @zbozis.update_all(:nakup_id=>@nakup.id)
          session[:cart] = nil
          if session[:customer_id].present?
            format.html { redirect_to customer_nakups_path(session[:customer_id]), notice: 'Nakup was successfully created.' }
            format.json { render :show, status: :created, location: @nakup }
          else
            format.html { redirect_to nakups_path, notice: 'Nakup was successfully created.' }
          end
        else
          format.html { render :new }
          format.json { render json: @nakup.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /nakups/1
  # PATCH/PUT /nakups/1.json
  def update
    respond_to do |format|
      if @nakup.update(nakup_params)
        if params["customer"]["customer_id"].present?
          @customer = Customer.find(params["customer"]["customer_id"])
          @nakup.customer = @customer
          @nakup.save
          @customer.nakups << @nakup
        end
        format.html { redirect_to customer_nakup_path, notice: 'Nakup was successfully updated.' }
        format.json { render :show, status: :ok, location: @nakup }
      else
        format.html { render :edit }
        format.json { render json: @nakup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nakups/1
  # DELETE /nakups/1.json
  def destroy
    id = @nakup.customer.id
    @nakup.zbozis.destroy_all
    @nakup.destroy
    respond_to do |format|
     
        format.html { redirect_to URI(request.referer || '').path, notice: 'Nakup was successfully destroyed.' }
        format.json { head :no_content }
    
    end
  end
  
  # POST nakups/add-zbozi
  def addZbozi
     @zbozi = Zbozi.new(zbozi_params)
    respond_to do |format|
      if @zbozi.save
         @cart = session[:cart]
       @product_id = @zbozi.id
       @id_p = Integer(@product_id)
       @product_id = nil
       @product_id = @id_p
       @new_cart = Array.new
       
       if @cart.present?
         @product_temp = @cart.find {|a| a["id"] == @product_id}
         p @product_temp.present?
         if @product_temp.present?
           @cart.each do |a,b|
             p a["id"] == Integer(@product_id)
             if a["id"] == Integer(@product_id)
               a["count"] += 1
               @new_cart << a
             else
               @new_cart << a 
             end
           end
          else
            @cart << {:id => @product_id, :count => 1}
            @new_cart = @cart
          end
      else
        @new_cart << {:id => @product_id, :count => 1}
      end
        session[:cart] = nil
        session[:cart] = @new_cart
        if session[:customer_id].present?
            format.html { redirect_to customer_nakups_path(session[:customer_id]), notice: 'Zbozi was successfully created.' }
            format.json { render :show, status: :created, location: @nakup }
          else
            format.html { redirect_to new_nakup_path, notice: 'Nakup was successfully created.' }
          end
      else
        format.html { render :new }
        format.json { render json: @zbozi.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def addZboziFromEdit
     @zbozi = Zbozi.new(zbozi_params)
     @nakup = Nakup.find(params[:nakup_id])
     @zbozi.nakup_id = @nakup.id
      respond_to do |format|
        if @zbozi.save
          @nakup.zbozis << @zbozi
          @cena = 0
          if @nakup.zbozis.present?
            @nakup.zbozis.each do |z|
              @cena += z.cena_za_kus * z.pocet_kusu
            end
          end
          @nakup.update(:cena_nakupu=>@cena)
          @nakup.save
          format.html { redirect_to edit_customer_nakup_path(@nakup.customer.id,@nakup.id), notice: 'Zboží bylo přidáno.' }
          format.json { render :show, status: :created, location: @nakup }
        else
          format.html { render :new }
          format.json { render json: @nakup.errors, status: :unprocessable_entity }
        end
      end  
  end
  
  def updateZboziFromNakup
    @zbozi = Zbozi.find(params["zbozi_id"])
    @nakup = Nakup.find(params["nakup_id"])
    respond_to do |format|
      if @zbozi.update(zbozi_params)
        @cena = 0
          if @nakup.zbozis.present?
            @nakup.zbozis.each do |z|
              @cena += z.cena_za_kus * z.pocet_kusu
            end
          end
          @nakup.update(:cena_nakupu=>@cena)
          @nakup.save
        format.html { redirect_to edit_customer_nakup_path(@nakup.customer.id,@nakup.id), notice: 'Nakup was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end
  
  def cleanNakup
      if session[:cart].present?
        a = Zbozi.where(:id=>session["cart"].map {|a,b| a["id"].to_i})
        a.destroy_all
        p " dsadsadsa" 
        session["cart"] = nil
        if session["last_page"] == "/nakups/new"
          redirect_to customer_nakups_path(session["customer_id"])
        elsess
          redirect_to nakups_path
        end
      else
        if !session["last_page"] == "/nakups/new"
          redirect_to customer_nakups_path(session["customer_id"])
        else
          redirect_to nakups_path
        end
      end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nakup
      @nakup = Nakup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nakup_params
      params.require(:nakup).permit(:cena_nakupu, :datum_nakupu, :planovanynakup)
    end
    
    def zbozi_params
      params.require(:zbozi).permit(:nazev, :popis, :pocet_kusu, :cena_za_kus)
    end
    
    def sort_column
      Nakup.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
