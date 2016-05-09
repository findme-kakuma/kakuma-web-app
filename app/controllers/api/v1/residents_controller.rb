class Api::V1::ResidentsController < Api::V1::BaseController
  def index
    residents = paginate Resident.registered

    render(
      json: ActiveModel::ArraySerializer.new(
        residents,
        each_serializer: Api::V1::ResidentSerializer,
        root: 'residents'
      )
    )
  end
end
