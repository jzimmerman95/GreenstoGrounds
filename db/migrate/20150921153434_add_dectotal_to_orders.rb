class AddDectotalToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :dectotal, :decimal
  end
end
