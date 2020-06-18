class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery with: :exception

    # Check if an appointment is 'valid'
    # Protects against incorrect URLs
    def appointment_valid?
        if !Appointment.exists?(params[:id])
            redirect_to patients_path, alert: "Appointment not found."
        elsif !Patient.exists?(params[:patient_id])
            redirect_to patients_path, alert: "Patient not found."
        else
            if @appointment.patient_id != @patient.id
            redirect_to patient_path(@patient), alert: "The selected appointment doesn't match with the selected patient."
            end
        end
    end

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
        devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end
end
