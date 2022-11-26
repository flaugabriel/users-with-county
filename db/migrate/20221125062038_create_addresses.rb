class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.integer :cep
      t.string :complement
      t.string :street
      t.string :neighborhood
      t.string :city
      t.string :uf
      t.string :ibge_code
      t.references :county, null: false, foreign_key: true

      t.timestamps
    end
  end
end
