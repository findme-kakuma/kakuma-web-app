class RemoveNameToCountries < ActiveRecord::Migration
  def change
    remove_column :countries, :name, :string
  end
end
