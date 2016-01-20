class RenameSearchResultsToSearches < ActiveRecord::Migration
  def change
    rename_table :search_results, :searches
  end
end
