class Resident < ActiveRecord::Base
  belongs_to :country

  validates :first_name,
            :last_name,
            :nickname,
            presence: true
end
