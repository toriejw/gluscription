class CreateSearchResults < ActiveRecord::Migration
  def change
    create_table :search_results do |t|
      t.string :medication
      t.string :gluten_free_status

      t.timestamps null: false
    end
  end
end
