class Appointment < ApplicationRecord
    belongs_to :user
    belongs_to :patient
    validates :appointment_date, :presence => true
end
