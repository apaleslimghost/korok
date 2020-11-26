class AddDefaultQuantityToPart < ActiveRecord::Migration[6.1]
  def change
    change_column_default :parts, :quantity, 0
  end
end
