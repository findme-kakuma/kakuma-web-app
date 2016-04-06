class Resident < ActiveRecord::Base
  belongs_to :country

  validates :first_name,
            :last_name,
            :country_id,
            :place,
            presence: true
end
