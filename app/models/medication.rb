class Medication < ActiveRecord::Base
  belongs_to :search
  enum gluten_free: [ :no, :yes, :maybe ]
end
