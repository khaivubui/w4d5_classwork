class RenameTypeForTracksTable < ActiveRecord::Migration[5.1]
  def change
    rename_column :tracks, :type, :track_type
  end
end
