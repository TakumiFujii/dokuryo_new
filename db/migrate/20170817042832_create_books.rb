class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :author
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end
end