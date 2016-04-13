class Resident < ActiveRecord::Base
  belongs_to :country

  has_many :relationships_applicants,
           class_name: 'Relationship',
           foreign_key: 'target_id'
  has_many :applicants,
           through: :relationships_applicants,
           class_name: 'Resident'
  has_many :relationships_targets,
           class_name: 'Relationship',
           foreign_key: 'applicant_id'
  has_many :targets,
           through: :relationships_targets,
           class_name: 'Resident'

  # Normalizes the attribute itself before validation
  phony_normalize :phone_number,
                  default_country_code: 'KE'

  validates :phone_number,
            phony_plausible: true,
            allow_blank: true

  validates :first_name,
            :last_name,
            :country_id,
            :place,
            presence: true

  accepts_nested_attributes_for :relationships_targets
end
