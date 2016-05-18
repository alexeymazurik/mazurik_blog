class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name

      t.timestamps null: false
    end

    add_reference :posts, :section, index: true
  end
end
