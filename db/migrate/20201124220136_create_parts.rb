class CreateParts < ActiveRecord::Migration[6.1]
  def change
    create_table :parts do |t|
      t.string :part_type
      t.string :value
      t.integer :quantity

      t.timestamps
    end
  end
end
