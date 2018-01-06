class MedicationSearchHandler

  def self.handle(search_term)
    new(search_term).handle
  end

  def initialize(search_term)
    @search_term = search_term
  end

  def handle
    if valid_cached_search_exists?
      saved_search = get_latest_search
      save_additional_search(saved_search)
      search_results = create_search_results(saved_search)
    else
      search_results = Search.return_results(@search_term)
      save_search(search_results)
    end

    search_results
  end

  private

    def cached_medication
      @cached_medication ||= Medication.find_by(name: @search_term.downcase)
    end

    def cached_search_exists?
      cached_medication
    end

    def valid_cached_search_exists?
      cached_medication &&
      cached_medication.updated_at > Date.today - 7
    end

    def create_cache(fda_drug)
      Medication.create!(
        name: @search_term.downcase,
        gluten_free: fda_drug.gluten_free?
      )
    end

    def create_or_update_cache(search_results)
      if cached_search_exists?
        update_cached_medication(search_results)
      else
        create_cache(search_results)
      end
    end

    def create_search_results(saved_search)
      OpenStruct.new(
        found?: true,
        name: saved_search.medication,
        gluten_free?: saved_search.gluten_free_status.to_sym,
        dangerous_ingredients: saved_search.suspect_ingredients.map(&:name).uniq
      )
    end

    def get_latest_search
      Search.where(search_term: @search_term.downcase).order(:created_at).last
    end

    def save_additional_search(saved_search)
      # we do this for analytics purposes
      duplicate_search = saved_search.dup
      duplicate_search.suspect_ingredients = saved_search.suspect_ingredients
      duplicate_search.save!
    end

    def save_search(search_results)
      if search_results.found?
        Search.save(search_results, @search_term)
        create_or_update_cache(search_results)
      else
        Search.save_failed_search(@search_term)
      end
    end

    def update_cached_medication(fda_drug)
      cached_medication.gluten_free = fda_drug.gluten_free?
      cached_medication.updated_at = Time.now
      cached_medication.save!
    end

end
