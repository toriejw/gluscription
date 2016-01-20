require "rails_helper"

RSpec.describe User, type: :model do
  def create_user
    User.create(name: "Dog")
  end

  it "can save a search" do
    user = create_user
    old_user_search_count = user.searches.count

    user.save_search(Drug.new("hi"))

    new_user_search_count = user.searches.count
    saved_result = user.searches.first

    expect(new_user_search_count - old_user_search_count).to eq(1)

    expect(saved_result.medication).to eq( "chloroxylenol 3.75 MG/ML Medicated Liquid Soap")
    expect(saved_result.gluten_free_status).to eq("yes")
    expect(saved_result.suspect_ingredients).to eq([])
  end

  it "only saves searches if they haven't already been searched" do
    user = create_user

    old_user_search_count = user.searches.count

    user.save_search(Drug.new("tylenol"))
    user.save_search(Drug.new("tylenol"))

    new_user_search_count = user.searches.count

    expect(new_user_search_count - old_user_search_count).to eq(1)
  end
end
