class CreateImcs < ActiveRecord::Migration[6.1]
  def change
    create_table :imcs do |t|
      t.decimal :height
      t.decimal :weight

      t.timestamps
    end
  end
end
