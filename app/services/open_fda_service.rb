require "hurley"

class OpenFDAService

  def self.return_raw_data(search_terms)
    response = Faraday.get("https://api.fda.gov/drug/label.json?search=inactive_ingredient:#{'"' + search_terms + '"'}")
    JSON.parse(response.body)
  end

end
