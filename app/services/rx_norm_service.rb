# require "hurley"

class RxNormService

  def self.find_drug_name(rxcui)
    response      = get_response(rxcui)
    json_response = parse_response(response)

    return_name(json_response)
  end

  def self.get_response(rxcui)
    Faraday.get("https://rxnav.nlm.nih.gov/REST/rxcui/#{rxcui}/status.json")
  end

  def self.parse_response(response)
    JSON.parse(response.body)
  end

  def self.return_name(json_response)
    json_response["rxcuiStatus"]["minConceptGroup"]["minConcept"][0]["name"]
  end

end
