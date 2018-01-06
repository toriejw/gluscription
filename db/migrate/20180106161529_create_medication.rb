class CreateMedication < ActiveRecord::Migration
  def change
    create_table :medications do |t|
      t.text :name, null: false
      t.integer :gluten_free

      t.timestamps null: false
    end
    add_index :medications, :name
  end
end
