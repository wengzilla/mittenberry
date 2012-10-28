class RemoveRequirementOnExternalId < ActiveRecord::Migration
  def change
    remove_column :payments, :external_id
    add_column :payments, :external_id, :string
  end
end
