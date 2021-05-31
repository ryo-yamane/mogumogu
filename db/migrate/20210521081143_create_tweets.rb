class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :name,               null: false
      t.string :text,               null: false
      t.integer :price,             null: false
      t.integer :category_id,       null: false
      t.integer :texture_id, null: false
      t.integer :jan_code
      t.integer :company_id, null: false
      t.timestamps
    end
  end
end
