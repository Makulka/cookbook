class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :body
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end
