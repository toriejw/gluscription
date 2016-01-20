class RenameColumnInSuspectIngredient < ActiveRecord::Migration
  def change
    rename_column :suspect_ingredients, "search_result_id", "search_id"
  end
end
