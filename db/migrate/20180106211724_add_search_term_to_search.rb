class AddSearchTermToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :search_term, :text
  end
end
