class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.string :name
      t.string :description
      t.string :ingredients
      t.integer :preparation_time
      t.string :servings
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :recipes
  end
end
