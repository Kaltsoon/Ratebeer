class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.text :name
      t.integer :beer_id

      t.timestamps
    end
  end
end
