class Ppl < ActiveRecord::Base
    belongs_to :customer
    validates :datum,:castka, :datumOdeslani, :cisloBaliku,:variabilniSymbol, presence: true
    scope :date_range, lambda {|start_date, end_date|  where("datum between ? and ?",start_date,end_date)}
    
    def autocomplete_customer_prijmeni
        tags = Customer.select([:prijmeni]).where("prijmeni || jmeno LIKE ?", "%#{params[:prijmeni]}%")
        result = tags.collect do |t|
          { value: t.name }
        end
        render json: result
  end
end
