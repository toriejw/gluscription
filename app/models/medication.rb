class Medication < ActiveRecord::Base
  enum gluten_free: [ :no, :yes, :maybe ]

  validates :name, uniqueness: true

  def gluten_free?
    gluten_free
  end
end
