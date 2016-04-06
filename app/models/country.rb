class Country < ActiveRecord::Base
  translates :name

  has_many :residents

  validates :name,
            presence: true
end
