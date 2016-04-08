class AddPhoneNumberToResidents < ActiveRecord::Migration
  def change
    add_column :residents, :phone_number, :string
  end
end
