class PatientsController < ApplicationController
    before_action :authenticate_user!

    def index
        @patients = Patient.all
    end

    def show
        @patient = Patient.find(params[:id])
        @appointments = @patient.appointments
    end

    def new
        @patient = Patient.new
        @patient.appointments.build
        @appointments = Appointment.all
    end

    def create
        @patient = Patient.new(patient_params)
        @patient.appointments.last.user_id = current_user.id

        if @patient.save
            redirect_to patient_path(@patient)
        else
            render 'new'
        end
    end

    def edit
        if !Patient.exists?(params[:id])
            redirect_to patients_path, alert: "Patient not found."
        else
            @patient = Patient.find(params[:id])
        end
    end


    def update
        @patient = Patient.find(params[:id])
        if @patient.update(patient_params)
            redirect_to patient_path(@patient)
        else
            render 'edit'
        end
    end


    def destroy
        @patient = Patient.find(params[:id])
        @patient.appointments.each do |appointment|
            if current_user.id == appointment.user_id
                appointment.destroy
            end
        end

        if !@patient.appointments.empty?
            redirect_to patients_path, alert: "You cannot delete this patient. It has appointments by other physicians."
        else
            @patient.destroy
            redirect_to patients_path    
        end
        
    end


    private
    def patient_params
        params.require(:patient).permit(:name, :age,
                                        appointments_attributes:
                                        [:appointment_date])
    end
end
