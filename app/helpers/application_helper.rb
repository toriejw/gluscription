module ApplicationHelper
  def gluten_free_or_not_message(drug)
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
    if !drug.has_ingredients?
      button_to "Try another search", root_path, method: :get, class: "btn btn-info"
    else
      content_tag :p, "This is based on the following information from the FDA:"
    end
  end
end
