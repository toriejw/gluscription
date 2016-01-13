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
    if @drug_data["error"]
      "not found"
    else
      RXnormService.find_drug_name(rxcui)
    end
  end

  def gluten_free?
    if !has_ingredients?
      :ingredients_not_listed
    elsif contains_ingredients_with_gluten?
      :false
    elsif contains_questionable_ingredients?
      :maybe
    else
      :true
    end
  end

  def contains_ingredients_with_gluten?
    gluten_containing_ingredients.each do |gluten_ingredient|
      return true if full_ingredient_list.include?(gluten_ingredient)
    end
    false
  end

  def contains_questionable_ingredients?
    possible_gluten_containing_ingredients.each do |gluten_ingredient|
      return true if full_ingredient_list.include?(gluten_ingredient)
    end
    false
  end

  def full_ingredient_list
    inactive_ingredients + active_ingredients
  end

  def has_ingredients?
    (@drug_data["results"][0]["inactive_ingredient"] &&
    @drug_data["results"][0]["active_ingredient"] &&
    raw_inactive_ingredients &&
    raw_active_ingredients)
  end

  private

    def gluten_containing_ingredients
      ["wheat", "barley", "rye", "wheatberries", "durum", "emmer", "semolina",
        "spelt", "dinkel", "farina", "farro", "faro", "graham", "khorasan",
        "einkorn", "triticale", "malt", "brewer's yeast", "wheat starch",
        "bulgur", "kamut", "matzo", "seitan", "atta", "fu", "couscous"]
    end

    def possible_gluten_containing_ingredients
      ["oats", "oat flour", "flour", "grain flour", "starch", "dextrin",
       "dextrate", "dextri-maltose", "maltodextrin", "starch", "modified start",
       "pregelatinized starch", "pre-gelatinized starch", "sodium starch glycolate",
       "dusting powder",]
    end

    def raw_inactive_ingredients
      @drug_data["results"][0]["inactive_ingredient"][0]
    end

    def raw_active_ingredients
      @drug_data["results"][0]["active_ingredient"][0]
    end

    def inactive_ingredients
      # because ingredients are returned from api in multiple forms, I'm taking
      # all words and treating them as 'ingredients' by splitting on spaces instead
      # of commas
      split_words = raw_inactive_ingredients.split(" ")
      format_words(split_words)
    end

    def active_ingredients
      split_words = raw_active_ingredients.split(" ")
      format_words(split_words)
    end

    def format_words(array)
      array.map do |word|
        word.gsub(",", "").downcase
      end
    end
end
