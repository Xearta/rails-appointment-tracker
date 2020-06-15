class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @appointments = Appointment.all
  end

  def show
    if !Appointment.exists?(params[:id])
      redirect_to patients_path, alert: "Appointment not found."
    elsif !Patient.exists?(params[:patient_id])
      redirect_to patients_path, alert: "Patient not found."
    else
      @appointment = Appointment.find(params[:id])
      @patient = Patient.find_by(id: params[:patient_id])
    end
  end

  def new
    @patient = Patient.find_by(id: params[:patient_id])
    @appointments = @patient.appointments
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
      redirect_to patient_path(@appointment.patient_id)
    else
      @patient = Patient.find(params[:patient_id])
      render 'new'
    end
  end

  def edit
    @patient = Patient.find_by(id: params[:patient_id])
    @appointment = Appointment.find_by(id: params[:id])
    if !Patient.exists?(params[:patient_id]) && !Appointment.exists?(params[:id])
      redirect_to patients_path, alert: "Appointment not found."
    elsif !Patient.exists?(params[:patient_id])
      redirect_to patients_path, alert: "Patient not found."
    else    
      if @appointment.user_id != current_user.id
        redirect_to patient_path(@patient), alert: "You cannot edit another physician's appointments."
      end
    end
  end

  def update
    @appointment = Appointment.find(params[:id])

    if @appointment.update(appointment_params)
      redirect_to patient_appointment_path(@appointment.patient_id, @appointment)
    else
      render 'edit'
    end
  end


  def destroy
    @appointment = Appointment.find(params[:id])
    if current_user.id == @appointment.user_id
      @appointment.destroy
      redirect_to patient_path(@appointment.patient)
    else
      redirect_to patient_path(@appointment.patient), alert: "You cannot delete another physician's appointments."
    end
  end


  private
  def appointment_params
    params.require(:appointment).permit(:appointment_date)
  end
end
