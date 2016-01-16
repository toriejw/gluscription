class AddSearchResultRefToSuspectIngredient < ActiveRecord::Migration
  def change
    add_reference :suspect_ingredients, :search_result, index: true, foreign_key: true
  end
end
