class Api::V1::ResidentSerializer < Api::V1::BaseSerializer
  attributes :id,
             :first_name,
             :last_name,
             :father_name,
             :grandfather_name,
             :country_id,
             :country_name,
             :place,
             :phone_number,
             :locale,
             :state,
             :created_at,
             :updated_at

  def country_name
    object.country.name
  end
end
