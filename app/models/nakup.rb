class Nakup < ActiveRecord::Base
    belongs_to :customer
    has_and_belongs_to_many :zbozis
    validates :cena_nakupu,:datum_nakupu, presence: true
end
