require_relative "../services/rx_norm_service.rb"

class Drug
  attr_reader :name, :drug_data
  attr_accessor :dangerous_ingredients

  def initialize(search_terms)
    @drug_data             = get_drug_data(search_terms)
    @name                  = get_drug_name
    @dangerous_ingredients = ["unknown"] # this is set as unknown instead of "" to make sure a blank list is never confused with a drug being GF
  end

  def rxcui
    @drug_data["results"][0]["openfda"]["rxcui"].first
  end

  def get_drug_data(search_terms)
    OpenFDAService.return_raw_data(search_terms)
  end

  def get_drug_name
    if @drug_data["error"] || missing_rxcui
      "not found"
    else
      RXnormService.find_drug_name(rxcui)
    end
  end

  def gluten_free?
    @dangerous_ingredients = []
    if !has_ingredients?
      :ingredients_not_listed
    elsif contains_ingredients_with_gluten?
      :no
    elsif contains_questionable_ingredients?
      :maybe
    else
      :yes
    end
  end

  def contains_ingredients_with_gluten?
    check_if_ingredients_include(gluten_containing_ingredients)
  end

  def contains_questionable_ingredients?
    check_if_ingredients_include(possible_gluten_containing_ingredients)
  end

  def full_ingredient_list
    inactive_ingredients + " " + active_ingredients
  end

  def has_ingredients?
    (@drug_data["results"][0]["inactive_ingredient"] &&
    @drug_data["results"][0]["active_ingredient"] &&
    raw_inactive_ingredients &&
    raw_active_ingredients)
  end

  private

    def gluten_containing_ingredients
      # spaces around words are to make sure we match the word itself and not part of a word
      [" wheat ", " barley ", " rye ", " wheatberries ", " durum ", " emmer ", " semolina ",
        " spelt ", " dinkel ", " farina ", " farro ", " faro ", " graham ", " khorasan ",
        " einkorn ", " triticale ", " malt ", "brewer's yeast ", "wheat starch ",
        " bulgur ", " kamut ", " matzo ", " seitan ", " atta ", " fu ", " couscous "]
    end

    def possible_gluten_containing_ingredients
      [" oats ", " oat flour ", " grain flour ", " grain ", " starch ", " dextrin ",
       " dextrate ", " dextri-maltose ", " maltodextrin ", " starch ",
       " pregelatinized starch ", " pre-gelatinized starch ", " sodium starch glycolate "]
    end

    def raw_inactive_ingredients
      @drug_data["results"][0]["inactive_ingredient"][0]
    end

    def raw_active_ingredients
      @drug_data["results"][0]["active_ingredient"][0]
    end

    def inactive_ingredients
      raw_inactive_ingredients.downcase
    end

    def active_ingredients
      raw_active_ingredients.downcase
    end

    def missing_rxcui
      !@drug_data["results"][0]["openfda"]["rxcui"]
    end

    def check_if_ingredients_include(list)
      list.each do |gluten_ingredient|
        @dangerous_ingredients << gluten_ingredient if full_ingredient_list.include?(gluten_ingredient)
      end

      dangerous_ingredients?
    end

    def dangerous_ingredients?
      !@dangerous_ingredients.empty?
    end
end
