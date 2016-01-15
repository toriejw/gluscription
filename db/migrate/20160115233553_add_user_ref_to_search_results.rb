class AddUserRefToSearchResults < ActiveRecord::Migration
  def change
    add_reference :search_results, :user, index: true, foreign_key: true
  end
end
