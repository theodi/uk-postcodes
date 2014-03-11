class AddGssToBoundary < ActiveRecord::Migration
  def change
    add_column :boundaries, :gss, :string
  end
end
