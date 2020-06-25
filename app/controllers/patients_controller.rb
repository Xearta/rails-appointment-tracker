class PatientsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_patient, only: [:show, :edit, :update, :destroy]

    def index
        @patients = Patient.search(params[:search])
    end

    def show
        if !Patient.exists?(params[:id])
            redirect_to patients_path, alert: "Patient not found."
        else
            @appointments = @patient.appointments.order(:appointment_date)
        end
    end

    def new
        @patient = Patient.new
        @patient.appointments.build
        @appointments = Appointment.order(:appointment_date)
    end

    def create
        @patient = Patient.new(patient_params)
        @patient.appointments.last.user_id = current_user.id

        if @patient.save
            redirect_to patient_path(@patient), notice: "Patient & Appointment created sucessfully."
        else
            @appointments = Appointment.all
            render 'new'
        end
    end

    def edit
        if !Patient.exists?(params[:id])
            redirect_to patients_path, alert: "Patient not found."
        else
            @appointments = @patient.appointments.last
        end
    end


    def update
        if @patient.update(patient_params)
            redirect_to patient_path(@patient)
        else
            render 'edit'
        end
    end


    def destroy
        @patient.appointments.each do |appointment|
            if current_user.appointments.include?(appointment)
                
                appointment.destroy
            end
        end
        
        if @patient.appointments.count > 0
            redirect_to patient_path(@patient), alert: "You cannot delete this patient. It has appointments by other physicians. However, your appointments with this patient have been removed."
        else
            @patient.destroy
            redirect_to patients_path, notice: "Patient deleted sucessfully."
        end        
    end


    private
    def patient_params
        params.require(:patient).permit(:name, :age, :search,
                                        appointments_attributes:
                                        [:appointment_date])
    end

    def find_patient
        @patient = Patient.find_by(id: params[:id])
    end
end
