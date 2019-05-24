class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :prerequisite
      t.integer :thumb_ups
      t.integer :thumb_downs
      t.string :img_name
      t.string :user
      t.string :desc
      t.integer :location
      t.integer :category

      t.timestamps
    end
  end
end
