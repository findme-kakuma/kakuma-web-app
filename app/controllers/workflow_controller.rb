class WorkflowController < ApplicationController
  include Wicked::Wizard

  STEPS = %I(
    #{'reset_session' if Rails.env.development?}
    your_profile
    your_family
    your_search
    proposal_for_new_search
    your_phone_number
  ).reject(&:empty?).freeze

  steps(*STEPS)

  def show
    load_resident
    case step
    when :reset_session
      session[:resident_id] = nil
      session[:force_new_search] = nil
      jump_to next_step
    when :your_profile
    when :your_family
      jump_to previous_step unless @resident.persisted?
    when :your_search
      jump_to previous_step unless @resident.persisted?
      load_relationship
    when :proposal_for_new_search
    when :your_phone_number
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
    @relationship = @resident.relationships_targets.last
    render_wizard @resident
    session[:force_new_search] = nil unless @resident.changed?
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

  def load_relationship
    session[:force_new_search] = params[:force_new_search] if params.key? :force_new_search
    @relationship = (
      (
        session[:force_new_search] != 'true' ||
        (
          @resident.relationships_targets.last.present? &&
          !@resident.relationships_targets.last.persisted?
        )
      ) &&
      @resident.relationships_targets.last
    ) || @resident.relationships_targets.build(target: Resident.new)
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
      :phone_number,
      relationships_targets_attributes: [
        :id,
        :type_of_relationship,
        target_attributes: [
          :id,
          :first_name,
          :last_name,
          :nickname,
          :country_id,
          :place,
          :father_name,
          :grandfather_name
        ]
      ]
    )
  end
end
