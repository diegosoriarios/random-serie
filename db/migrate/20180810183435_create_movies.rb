class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :ano
      t.string :sinopse
      t.string :image
      t.string :nota
      t.string :vermais
      t.timestamps
    end
  end
end
