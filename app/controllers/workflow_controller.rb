class WorkflowController < ApplicationController
  include Wicked::Wizard

  STEPS = %I(
    #{'reset_session' if Rails.env.development?}
    presentation
    your_profile
    your_phone_number
    your_search
    proposal_for_new_search
  ).reject(&:empty?).freeze

  steps(*STEPS)

  def show
    load_resident
    case step
    when :reset_session
      session.delete :resident_id
      session.delete :force_new_search
      jump_to next_step
    when :your_phone_number
      jump_to previous_step unless @resident.persisted?
    when :your_search
      jump_to previous_step unless @resident.persisted?
      load_relationship
      jump_to next_step unless session.key? :force_new_search
    end
    render_wizard
  end

  def create
    if params.key?(:resident)
      @resident = Resident.where(
        first_name: params[:resident][:first_name],
        last_name:  params[:resident][:last_name],
        country_id: params[:resident][:country_id],
        place:      params[:resident][:place]
      ).first_or_initialize permited_params
    else
      @resident = Resident.new permited_params
    end
    @resident.locale = I18n.locale
    render_wizard @resident
    session[:resident_id] = @resident.id
    session.delete :force_new_search
  end

  def update
    load_resident
    @resident.assign_attributes permited_params
    case step
    when :your_phone_number
      @resident.register
    when :your_search
      @relationship = @resident.relationships_targets.last
    end
    render_wizard @resident
    session[:force_new_search] = 'false' if session.key?(:force_new_search) &&
                                            !@resident.changed? # update success
  end

  private

  def finish_wizard_path
    load_resident
    if @resident.persisted?
      session.delete :resident_id
      session.delete :force_new_search
      resident_path(@resident)
    else
      root_path
    end
  end

  def load_resident
    @resident = Resident.find_by(id: session[:resident_id]) || Resident.new
  end

  def load_relationship
    if params.key? :force_new_search
      session[:force_new_search] = params[:force_new_search]
    end
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
