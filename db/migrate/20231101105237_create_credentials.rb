class CreateCredentials < ActiveRecord::Migration[7.0]
  def change
    create_table :credentials do |t|
      t.string :shop
      t.text :scopes
      t.string :access_token

      t.timestamps
    end
  end
end
