class SearchResult < ActiveRecord::Base
  belongs_to :user
  has_many :suspect_ingredients
end
