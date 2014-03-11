class ChangeBoundaryShapeType < ActiveRecord::Migration
  def change
    change_column :boundaries, :shape, :geometry
  end
end
