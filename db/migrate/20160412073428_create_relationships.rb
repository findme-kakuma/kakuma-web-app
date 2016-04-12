class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.references :root, index: true
      t.references :target, index: true
      t.string :type

      t.timestamps null: false
    end
  end
end
