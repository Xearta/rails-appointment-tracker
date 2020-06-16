class Patient < ApplicationRecord
    has_many :appointments
    has_many :users, :through => :appointments
    accepts_nested_attributes_for :appointments
    validates :name, :presence => true,
                     :uniqueness => true
    validates :age, :presence => true


    def self.search(search)
        if search
            patients = []
            Patient.where("name LIKE ?", "%#{search}%").find_each do |patient|
                patients << patient
            end
            patients
        else
            Patient.all
        end
    end
end