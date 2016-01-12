class Drug
  attr_reader :name

  def initialize(search_terms)
    @drug_data = OpenFDAService.call(search_terms)
    @name = nil
  end

end
