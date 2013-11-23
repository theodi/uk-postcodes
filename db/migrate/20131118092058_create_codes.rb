class CreateCodes < ActiveRecord::Migration
  def up
    create_table :codes do |t|
      t.string :name
      t.string :snac
      t.string :os
      t.string :gss
      t.string :type
    end
  end

  def down
  end
end
