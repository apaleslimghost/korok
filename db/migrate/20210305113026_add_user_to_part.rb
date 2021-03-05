class AddUserToPart < ActiveRecord::Migration[6.1]
  def change
    add_reference :parts, :user, null: false, foreign_key: true
  end
end
