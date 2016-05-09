class Api::V1::ResidentSerializer < Api::V1::BaseSerializer
  attributes :uuid,
             :first_name,
             :last_name,
             :nickname,
             :father_name,
             :grandfather_name,
             :country_name,
             :place,
             :created_at,
             :updated_at

  def country_name
    object.country.name
  end
end
