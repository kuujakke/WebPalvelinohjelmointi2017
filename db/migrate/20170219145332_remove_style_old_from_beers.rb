class RemoveStyleOldFromBeers < ActiveRecord::Migration[5.0]
  def change
    remove_column :beers, :style_old
  end
end
