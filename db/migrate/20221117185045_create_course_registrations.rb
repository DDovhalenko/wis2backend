class CreateCourseRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :course_registrations do |t|
      t.belongs_to :user
      t.belongs_to :course
      t.timestamps
    end
    add_index :course_registrations, [:user_id, :course_id], unique: true
  end
end
