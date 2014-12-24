class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
    	
    	t.references :photo, index: true

      t.timestamps
    end
  end
end
