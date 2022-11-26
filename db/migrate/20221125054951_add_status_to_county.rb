class AddStatusToCounty < ActiveRecord::Migration[7.0]
  def change
    add_column :counties, :status, :integer, default: 0
  end
end
