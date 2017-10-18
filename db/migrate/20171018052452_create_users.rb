class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :location
      t.string :image
      t.string :twitter
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
