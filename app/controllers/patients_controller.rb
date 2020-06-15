class PatientsController < ApplicationController
    before_action :authenticate_user!

    def index
        @patients = Patient.all
    end

    def show
        @patient = Patient.find(params[:id])
        @appointments = @patient.appointments
    end


    private
    def patient_params
        params.require(:patient).permit(:name, :age)
    end
end
