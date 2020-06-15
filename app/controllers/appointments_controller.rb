class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @appointments = Appointment.all
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @patient = Patient.find_by(id: params[:patient_id])
    if params[:patient_id] && !Patient.exists?(params[:patient_id])
      redirect_to patients_path, alert: "Patient not found."
    elsif params[:patient_id]
      @appointment = Appointment.new(patient_id: params[:patient_id])
    else
      @appointment = Appointment.new
    end
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user_id = current_user.id
    @appointment.patient_id = params[:patient_id]

    if @appointment.save
      redirect_to patient_appointment_path(@appointment.patient_id, @appointment)
    else
      render :new
    end
  end


  private
  def appointment_params
    params.require(:appointment).permit(:appointment_date)
  end
end
