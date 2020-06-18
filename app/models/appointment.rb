class Appointment < ApplicationRecord
    belongs_to :user
    belongs_to :patient
    validates :appointment_date, :presence => true
    
    #scope :user_appointments, where('appointment.user_id = ?', current_user.id)
    scope :expired, -> { where("appointment_date < ?", (Time.now - 14400)) }
    scope :current, -> { where("appointment_date > ?", (Time.now - 14400)) }

end
