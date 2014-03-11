class ChangeBoundaryTypeToKind < ActiveRecord::Migration
  def up
    rename_column :boundaries, :type, :kind
  end

  def down
  end
end
