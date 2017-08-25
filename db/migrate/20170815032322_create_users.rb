class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email
      t.string :password_digest
      t.string :image
      t.string :gender
      t.string :bestbook

      t.timestamps
    end
  end
end
