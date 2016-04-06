class AddFatherNameAndGrandfatherNameToResidents < ActiveRecord::Migration
  def change
    add_column :residents, :father_name, :string
    add_column :residents, :grandfather_name, :string
  end
end
