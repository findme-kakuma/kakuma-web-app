class Relationship < ActiveRecord::Base
  TYPES = %w(
    mother
    father
    son
    daughter
    brother
    sister
    wife
    husband
    other
  ).freeze

  belongs_to :applicant, class_name: 'Resident'
  belongs_to :target, class_name: 'Resident'

  validates :type_of_relationship,
            presence: true,
            inclusion: { in: TYPES }

  accepts_nested_attributes_for :target

  after_commit :notify_target, on: [:create, :update]

  def target_attributes=(attrs)
    self.target = Resident.where(
      first_name: attrs[:first_name],
      last_name:  attrs[:last_name],
      country_id: attrs[:country_id],
      place:      attrs[:place]
    ).first_or_initialize attrs
  end

  private

  def notify_target
    NotifyResident.enqueue target_id, id, nil
  end
end
