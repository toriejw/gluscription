class CreateSearchResults < ActiveRecord::Migration
  def change
    create_table :search_results do |t|
      t.string :medication
      t.boolean :gluten_free

      t.timestamps null: false
    end
  end
end
