class CreateUserCommentRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :user_comment_ratings do |t|
      t.integer :value
      t.references :comment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
