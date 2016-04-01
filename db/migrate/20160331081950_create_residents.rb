class CreateResidents < ActiveRecord::Migration
  def change
    create_table :residents do |t|
      t.string :first_name
      t.string :last_name
      t.string :nickname

      t.timestamps null: false
    end
  end
end
