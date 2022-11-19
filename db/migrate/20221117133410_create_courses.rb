class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.belongs_to :user
      t.string :name
      t.string :full_name
      t.text :description
      t.string :course_type
      t.float :price
      t.integer :limit
      t.timestamps
    end
  end
end
