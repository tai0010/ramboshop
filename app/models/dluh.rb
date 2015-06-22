class Dluh < ActiveRecord::Base
    belongs_to :customer
    validates :dluh, presence: true
end
