class CreateZipcodes < ActiveRecord::Migration[6.0]
  def change
    create_table :zipcodes do |t|
      t.boolean :saturday_enabled
      t.string :city

      t.timestamps
    end
  end
end
