class Patient < ApplicationRecord
    has_many :appointments
    has_many :users, :through => :appointments
    accepts_nested_attributes_for :appointments
    validates :name, :presence => true,
                     :uniqueness => true
    validates :age, :presence => true
end
