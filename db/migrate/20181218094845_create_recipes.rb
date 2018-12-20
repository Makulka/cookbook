class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.text :ingredients
      t.text :steps
      t.text :link
      t.integer :creator_id
      t.integer :user_id
      t.timestamps
    end
  end
end
