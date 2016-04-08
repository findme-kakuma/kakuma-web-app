class WorkflowController < ApplicationController
  include Wicked::Wizard

  STEPS = %I(
    #{'reset_session' if Rails.env.development?}
    your_profile
    your_family
    your_phone_number
  ).reject(&:empty?).freeze

  steps(*STEPS)

  def show
    load_resident
    case step
    when :reset_session
      session[:resident_id] = nil
      jump_to next_step
    when :your_profile
    when :your_family
      jump_to previous_step unless @resident.persisted?
    end
    render_wizard
  end

  def create
    @resident = Resident.new permited_params
    render_wizard @resident
    session[:resident_id] = @resident.id
  end

  def update
    load_resident
    @resident.assign_attributes permited_params
    render_wizard @resident
  end

  private

  def finish_wizard_path
    load_resident
    if @resident.persisted?
      session[:resident_id] = nil
      resident_path(@resident)
    else
      root_path
    end
  end

  def load_resident
    @resident = (
      session[:resident_id] && Resident.find_by(id: session[:resident_id])
    ) || Resident.new
  end

  def permited_params
    params.require(:resident).permit(
      :first_name,
      :last_name,
      :nickname,
      :country_id,
      :place,
      :father_name,
      :grandfather_name,
      :phone_number
    )
  end
end
