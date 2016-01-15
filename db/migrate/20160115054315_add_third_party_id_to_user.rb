class AddThirdPartyIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :third_party_id, :string
  end
end
