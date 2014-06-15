class CreateTestdbs < ActiveRecord::Migration
  def change
    create_table :testdbs do |t|
      t.string :name

      t.timestamps
    end
  end
end
