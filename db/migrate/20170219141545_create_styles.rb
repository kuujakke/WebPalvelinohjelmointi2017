class CreateStyles < ActiveRecord::Migration[5.0]
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
    change_table :beers do |t|
      t.rename :style, :style_old
      t.integer :style_id
    end
  end
end
