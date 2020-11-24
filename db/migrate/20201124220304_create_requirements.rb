class CreateRequirements < ActiveRecord::Migration[6.1]
  def change
    create_table :requirements do |t|
      t.integer :quantity
      t.references :part, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
