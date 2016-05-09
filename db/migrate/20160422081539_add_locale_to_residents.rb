class AddLocaleToResidents < ActiveRecord::Migration
  def change
    add_column :residents, :locale, :string
  end
end
