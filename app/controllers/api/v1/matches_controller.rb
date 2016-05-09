class Api::V1::MatchesController < Api::V1::BaseController
  def index
    matches = paginate Relationship.matches

    render(
      json: ActiveModel::ArraySerializer.new(
        matches,
        each_serializer: Api::V1::RelationshipSerializer,
        root: 'matches'
      )
    )
  end
end
