require_relative "../services/rx_norm_service.rb"

class Drug
  attr_reader :name, :drug_data

  def initialize(search_terms)
    @drug_data = get_drug_data(search_terms)
    @name      = get_drug_name
  end

  def rxcui
    @drug_data["results"][0]["openfda"]["rxcui"].first
  end

  def get_drug_data(search_terms)
    OpenFDAService.return_raw_data(search_terms)
  end

  def get_drug_name
    RXnormService.find_drug_name(rxcui)
  end

  def gluten_free?
    true
  end
end
