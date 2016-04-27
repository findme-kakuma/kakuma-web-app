class Relationship < ActiveRecord::Base
  TYPES = %i(
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
  belongs_to :registered_target,
             -> { where(state: 'registered') },
             class_name: 'Resident',
             foreign_key: 'target_id'

  validates :type_of_relationship,
            presence: true,
            inclusion: { in: TYPES.map(&:to_s) }

  accepts_nested_attributes_for :target

  scope :matches, -> { joins(:registered_target) }

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
