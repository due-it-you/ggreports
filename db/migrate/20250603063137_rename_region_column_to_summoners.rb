class RenameRegionColumnToSummoners < ActiveRecord::Migration[7.2]
  def change
    rename_column :summoners, :region, :platform
  end
end
