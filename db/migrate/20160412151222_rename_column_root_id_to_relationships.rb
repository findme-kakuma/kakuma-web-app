class RenameColumnRootIdToRelationships < ActiveRecord::Migration
  def change
    remove_reference :relationships, :root, index: true
    add_reference :relationships, :applicant, index: true
  end
end
