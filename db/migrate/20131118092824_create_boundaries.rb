class CreateBoundaries < ActiveRecord::Migration
  def up
    create_table :boundaries do |t|
      t.string :code
      t.string :name
      t.string :type
      t.polygon :shape
    end
    
    add_index :boundaries, :code, :unique => true
  end

  def down
  end
end
