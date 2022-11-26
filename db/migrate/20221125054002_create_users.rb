class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :cpf
      t.string :cns
      t.string :email
      t.date :birth_date
      t.string :phone
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
