class AddSpatialIndexToBoundaries < ActiveRecord::Migration
  def change
    def change
      execute <<-SQL
          CREATE INDEX boundary_shape ON boundaries USING GIST ( shape );
      SQL
    end
  end
end
