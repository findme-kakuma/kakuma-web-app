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
end
