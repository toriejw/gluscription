module ApplicationHelper
  def gluten_free_or_not_message(drug)
    return "Sorry, we couldn't find the drug you searched for." if drug.name == "not found"

    gluten_free_status = drug.gluten_free?

    if gluten_free_status == :ingredients_not_listed
      "Sorry, the FDA has not provided ingredients for this drug :("
    elsif gluten_free_status == :true
      "is gluten-free!"
    elsif gluten_free_status == :maybe
      "may or may not be gluten-free."
    else
      "is NOT gluten-free :( !"
    end
  end

  def additional_info_or_search_again_button(drug)
    if drug.name == "not found" || !drug.has_ingredients?
      button_to "Try another search", root_path, method: :get, class: "btn btn-info"
    else
      list_of_concerning_ingredients(drug)
    end
  end

  def list_of_concerning_ingredients(drug)
    if drug.dangerous_ingredients.empty?
      ingredients_list = "none"
    else
      ingredients_list = drug.dangerous_ingredients.uniq.join(", ")
    end
    content_tag :p, "Ingredients of concern: #{ingredients_list}"
  end
end
