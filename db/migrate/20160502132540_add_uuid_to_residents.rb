class AddUuidToResidents < ActiveRecord::Migration
  def change
    add_column :residents, :uuid, :uuid, default: 'uuid_generate_v4()'
  end
end
