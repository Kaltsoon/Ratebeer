class RemoveBeerIdFromStyle < ActiveRecord::Migration
  def change
  	remove_column :styles, :beer_id
  end
end
