class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :review_desc
      t.references :user, foreign_key: true
      t.references :idea, foreign_key: true, index: true

      t.timestamps
    end
  end
end
