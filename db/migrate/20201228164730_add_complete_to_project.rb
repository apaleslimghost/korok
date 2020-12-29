class AddCompleteToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :complete, :boolean, default: false
  end
end
