class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :produce
      t.integer :snack
      t.text :alacarte
      t.text :comments
      t.string :code

      t.timestamps null: false
    end
  end
end
