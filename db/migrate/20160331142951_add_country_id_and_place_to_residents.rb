class AddCountryIdAndPlaceToResidents < ActiveRecord::Migration
  def change
    add_reference :residents, :country, index: true, foreign_key: true
    add_column :residents, :place, :string
  end
end
