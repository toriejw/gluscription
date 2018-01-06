require "rails_helper"

describe MedicationSearchHandler do
  let(:med_name) { "Levothyroxine" }
  let(:gluten_free) { "yes" }
  let(:fda_drug) {
    double(:fda_drug,
           name: med_name,
           found?: true,
           gluten_free?: gluten_free,
           dangerous_ingredients: [])
  }

  before do
    allow(Search).to receive(:return_results).and_return(fda_drug)
  end

  describe ".handle" do
    context "the same search was performed within the last week" do
      let!(:medication_cache) {
        Medication.create!(updated_at: Date.today - 5, name: med_name, gluten_free: "yes")
      }
      let!(:latest_search) { Search.create!(medication: med_name) }

      it "returns the saved results" do
        results = described_class.handle(med_name)

        expect(results.name).to eq med_name
        expect(results.gluten_free?).to eq gluten_free
        expect(results.dangerous_ingredients).to eq []
      end

      it "saves the results" do
        expect {
          described_class.handle(med_name)
        }.to change {
          Search.count
        }.by 1
      end
    end

    context "the same search was performed longer than a week ago" do
      let!(:medication_cache) {
        Medication.create!(updated_at: Date.today - 8, name: med_name.downcase, gluten_free: "yes")
      }
      let(:gluten_free) { "no" }

      it "performs a new search" do
        expect(Search).to receive(:return_results).with(med_name)

        described_class.handle(med_name)
      end

      context "gluten free status has changed" do
        it "updates the existing saved results" do
          expect(medication_cache.gluten_free?).to eq "yes"

          described_class.handle(med_name)

          expect(medication_cache.reload.gluten_free?).to eq "no"
        end
      end

      context "gluten free status has not changed" do
        it "updates the update_at timestamp of the existing saved results" do
          expect(medication_cache.reload.updated_at.to_date).to_not eq Date.today

          described_class.handle(med_name)

          expect(medication_cache.reload.updated_at.to_date).to eq Date.today
        end
      end
    end

    context "the search has never been performed" do
      it "performs a new search" do
        expect(Search).to receive(:return_results).with(med_name)

        described_class.handle(med_name)
      end

      it "saves the results" do
        expect {
          described_class.handle(med_name)
        }.to change {
          Search.count
        }.by 1

        described_class.handle(med_name)

        saved_search = Search.last

        expect(saved_search.medication).to eq med_name.downcase
        expect(saved_search.gluten_free_status).to eq "yes"
      end

      it "saves a cache of the medication" do
        expect {
          described_class.handle(med_name)
        }.to change {
          Medication.count
        }.by 1

        saved_med = Medication.last

        expect(saved_med.name).to eq med_name.downcase
        expect(saved_med.gluten_free?).to eq "yes"
      end
    end
  end
end
