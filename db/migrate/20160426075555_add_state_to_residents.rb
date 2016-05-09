class AddStateToResidents < ActiveRecord::Migration
  def change
    add_column :residents, :state, :string
  end
end
