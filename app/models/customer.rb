class Customer < ActiveRecord::Base
    has_and_belongs_to_many :nakups
    has_and_belongs_to_many :poznamkas, :dependent => :destroy
    has_and_belongs_to_many :dluhs, :dependent => :destroy
    has_and_belongs_to_many :ppls
    has_one :rating

    
    def name_with_initial
        "#{jmeno.first}. #{prijmeni}"
    end
    scope :date_range, lambda {|start_date, end_date|  where("datumkontaktu between ? and ?",start_date,end_date)}
    scope :search, lambda {|word|  where("prijmeni || jmeno || mobcislo like ? ", "%#{word}%")}
   # scope :search, lambda {|word|  mysearch(word)}
    validates :prijmeni, :uniqueness => {:scope => :jmeno}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :jmeno, :prijmeni, presence: true
                    
    priority = ["modra","cervena","orange","magenta","white"]
    
    def kontroladata
        @planovane_nakupy = self.nakups.where(:planovanynakup=>true)
        if @planovane_nakupy.present?
            if kontrolaDataPlanovanehoNakupu(@planovane_nakupy)
                kontrolaBarvy("modra")
                return "modra"
            else
                if kontrolaPoXDnech(self.datumkontaktu)
                    kontrolaBarvy("cervena")
                    return "cervena"
                else
                end
            end
        else
            if self.kontaktovan == false
                if kontrolaData30Dni(self.datumkontaktu)
                    kontrolaBarvy("cervena")
                    return "cervena"
                elsif kontrolaData14Dni(self.datumkontaktu)
                    if self.odpoved
                        kontrolaBarvy("magenta")
                        return "magenta"
                    else
                        kontrolaBarvy("orange")
                        return "orange"
                    end
                else
                    if self.odpoved
                        kontrolaBarvy("magenta")
                        return "magenta"
                    else
                        kontrolaBarvy("white")
                        return "white"
                    end
                end
            elsif kontrolaData30Dni(self.datumkontaktu)
                kontrolaBarvy("cervena")
                return "cervena"
            else
                if self.odpoved
                    kontrolaBarvy("magenta")
                    return "magenta"
                else
                    kontrolaBarvy("white")
                    return "white"
                end
            end
        end
    end
    def self.mysearch(word)
        ActiveSupport::Inflector.transliterate(word.downcase)
        g = []
        Customer.all.each do |a|
           g << a if ActiveSupport::Inflector.transliterate(a.jmeno.downcase) ==  word || ActiveSupport::Inflector.transliterate(a.jmeno.downcase).include?(word) || ActiveSupport::Inflector.transliterate(a.prijmeni.downcase) ==  word || ActiveSupport::Inflector.transliterate(a.prijmeni.downcase).include?(word) || a.mobcislo ==  word || a.mobcislo.to_s.include?(word)
        end
        return g
        
    end
    
  
    
    private
    
    def kontrolaData14Dni(datum)
        count = 14
        someDaysLater = (DateTime.now - count.days)
        return datum < someDaysLater #kdyz je true tak je treba klienta kontaktovat
    end
    
    def kontrolaData30Dni(datum)
        count = 30
        someDaysLater = (DateTime.now - count.days)
        return datum < someDaysLater #kdyz je true tak je treba klienta kontaktovat
    end
    
    def kontrolaDataPlanovanehoNakupu(planovane_nakupy)
        daylater = (DateTime.now + 5.days)
        dnes = DateTime.now
        datum = planovane_nakupy.first.datum_nakupu
        if dnes == datum || (dnes < datum && dnes < datum)
            return true
        else
            return false
        end
    end
    
    def kontrolaPoXDnech(datum)
        dateLater = datum + 5.days
        return DateTime.now > dateLater
    end
    
    def kontrolaBarvy(barva)
        if self.barva != barva
            self.barva = barva
            self.save
        end
    end
    
    
   
end
