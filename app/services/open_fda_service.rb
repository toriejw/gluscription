require "hurley"

class OpenFDAService
  
  def self.call(search_terms)
    response = Hurley.get("https://api.fda.gov/drug/label.json?search=inactive_ingredient:#{search_terms}")
    response.body
  end

end
