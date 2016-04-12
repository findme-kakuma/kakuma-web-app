class Resident < ActiveRecord::Base
  belongs_to :country

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
end
