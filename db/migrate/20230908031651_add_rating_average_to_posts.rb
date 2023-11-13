class AddRatingAverageToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :rating_average, :decimal, precision: 2, scale: 1, default: 0, null: false
  end
end
