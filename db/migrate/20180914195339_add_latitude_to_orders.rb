class AddLatitudeToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :latitude, :float
  end
end
