class Patient < ApplicationRecord
    has_many :appointments
    has_many :users, :through => :appointments
    accepts_nested_attributes_for :appointments
    validates :name, :presence => true,
                     :uniqueness => true,
                     :format => { with: /\D/, message: "%{value} is not valid. Must only contain letters." }
    validates :age, :presence => true

    scope :search, -> (search) { where("name LIKE ?", "%#{search}%") }

    
end