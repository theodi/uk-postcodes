class ChangeCodeTypeToKind < ActiveRecord::Migration
  def up
    rename_column :codes, :type, :kind
  end

  def down
  end
end
