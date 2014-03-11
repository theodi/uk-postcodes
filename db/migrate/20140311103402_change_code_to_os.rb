class ChangeCodeToOs < ActiveRecord::Migration
  def change
    rename_column :boundaries, :code, :os
  end
end
