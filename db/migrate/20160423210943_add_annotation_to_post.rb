class AddAnnotationToPost < ActiveRecord::Migration
  def change
    add_column :posts, :annotation, :text
  end
end
