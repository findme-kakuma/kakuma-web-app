class Api::V1::RelationshipSerializer < Api::V1::BaseSerializer
  attributes :id, :created_at, :updated_at, :type_of_relationship

  has_one :applicant, serializer: Api::V1::ResidentSerializer
  has_one :target, serializer: Api::V1::ResidentSerializer

  def type_of_relationship
    I18n.t object.type_of_relationship,
           scope: 'simple_form.options.defaults.type_of_relationship' if
             object.type_of_relationship.present?
  end
end
