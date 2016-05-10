class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.string :user
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
