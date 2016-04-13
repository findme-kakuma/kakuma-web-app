class RenameColumnTypeToRelationships < ActiveRecord::Migration
  def change
    rename_column :relationships, :type, :type_of_relationship
  end
end
