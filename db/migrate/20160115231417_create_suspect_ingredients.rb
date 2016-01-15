class CreateSuspectIngredients < ActiveRecord::Migration
  def change
    create_table :suspect_ingredients do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
