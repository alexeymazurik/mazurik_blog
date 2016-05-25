class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.string :image_src
      t.string :author
      t.text :annotation
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
