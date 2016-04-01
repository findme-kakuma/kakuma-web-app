class Country < ActiveRecord::Base
  has_many :residents

  validates :name,
            presence: true
end
