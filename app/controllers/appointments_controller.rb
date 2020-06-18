class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_appointment, only: [:show, :edit, :update, :destroy]
  before_action :find_patient, only: [:show, :edit, :new, :create]
  
  def index
    @appointments = Appointment.all.order(:appointment_date
    )
    @expired_appointments = Appointment.expired
  end

  #appointment_valid? is in the application controller
  def show
    appointment_valid?
  end

  #appointment_valid? is in the application controller
  def edit
    appointment_valid?
    if @appointment.user_id != current_user.id
      redirect_to patient_path(@patient), alert: "You cannot edit another physician's appointments."
    end
  end

  def new
    if !Patient.exists?(params[:patient_id])
      redirect_to patients_path, alert: "You cannot make an appointment for a non-existent patient."
    else
      @appointments = @patient.appointments.order(:appointment_date)
      @appointment = Appointment.new(patient_id: params[:patient_id])
    end
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user_id = current_user.id
    @appointment.patient_id = params[:patient_id]

    if @appointment.save
      redirect_to patient_path(@appointment.patient_id), notice: "Appointment for #{@patient.name} created sucessfully."
    else
      @appointments = Appointment.all
      render 'new'
    end
  end

  
  def update
    if @appointment.update(appointment_params)
      redirect_to patient_appointment_path(@appointment.patient_id, @appointment)
    else
      render 'edit'
    end
  end

  # Custom Route that will delete all 'expired' appointments
  # Usage of a scope method chained with .delete_all
  def destroy_all_expired
    Appointment.expired.delete_all
    redirect_to root_path, notice: "Expired appointments deleted successfully."
  end

  # This will only destroy 1 appt at a time - Only if you are the owner
  def destroy
    if current_user.id == @appointment.user_id
      @appointment.destroy
      redirect_to patient_path(@appointment.patient), notice: "Appointment deleted sucessfully."
    else
      redirect_to patient_path(@appointment.patient), alert: "You cannot delete another physician's appointments."
    end
  end


  private
  def appointment_params
    params.require(:appointment).permit(:appointment_date)
  end

  def find_appointment
    @appointment = Appointment.find_by(id: params[:id])
  end

  def find_patient
    @patient = Patient.find_by(id: params[:patient_id])
  end
end
