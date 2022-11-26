class CreateUserCounties < ActiveRecord::Migration[7.0]
  def change
    create_table :user_counties do |t|
      t.references :user, null: false, foreign_key: true
      t.references :county, null: false, foreign_key: true

      t.timestamps
    end
  end
end
