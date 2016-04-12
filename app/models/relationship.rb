class Relationship < ActiveRecord::Base
  belongs_to :root, class_name: 'Resident'
  belongs_to :target, class_name: 'Resident'

  validates :type,
            presence: true
end
