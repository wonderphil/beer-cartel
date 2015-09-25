class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :email
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.integer :postcode
      t.string   :password_digest
      t.string   :remember_digest
      t.boolean  :admin,             default: false
      t.string   :activation_digest
      t.boolean  :activated,         default: false
      t.datetime :activated_at
      t.string   :reset_digest
      t.datetime :reset_sent_at

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
