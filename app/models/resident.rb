class Resident < ActiveRecord::Base
  include AASM

  belongs_to :country

  has_many :relationships_applicants,
           class_name: 'Relationship',
           foreign_key: 'target_id',
           dependent: :destroy
  has_many :applicants,
           through: :relationships_applicants,
           class_name: 'Resident'
  has_many :relationships_targets,
           class_name: 'Relationship',
           foreign_key: 'applicant_id',
           dependent: :destroy
  has_many :targets,
           through: :relationships_targets,
           class_name: 'Resident'

  # Normalizes the attribute itself before validation
  phony_normalize :phone_number,
                  default_country_code: 'KE'

  validates :phone_number,
            phony_plausible: true,
            allow_blank: true
  validates :phone_number,
            presence: true, if: Proc.new { |r| r.registered? }

  validates :first_name,
            :last_name,
            :country_id,
            :place,
            presence: true

  accepts_nested_attributes_for :relationships_targets

  after_commit :push_resident, on: [:create, :update]

  aasm column: 'state' do
    state :target, initial: true
    state :registered

    event :register do
      transitions from: [:target, :registered], to: :registered
    end
  end

  def full_name(options = {})
    %W(
      #{first_name}
      #{last_name}
      #{"(#{phone_number})" if phone_number.present? &&
                               options[:with_phone_number]}
    ).reject(&:empty?).freeze.join(' ')
  end

  def notifiable?
    phone_number.present?
  end

  def notify(relationship)
    if notifiable?
      body = I18n.t :your_profile_match,
                    target_first_name: first_name,
                    applicant_full_name: relationship.applicant.full_name(
                      with_phone_number: true
                    ),
                    locale: (locale || I18n.default_locale)
      twilio_client = Twilio::REST::Client.new
      twilio_client.messages.create(
        from: Figaro.env.twilio_from,
        to: phone_number,
        body: body
      )
    end
  end

  private

  def push_resident
    PushResident.enqueue id if registered?
  end
end
