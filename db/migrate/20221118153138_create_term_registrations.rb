class CreateTermRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :term_registrations do |t|
      t.belongs_to :user
      t.belongs_to :term
      t.float :grade
      t.timestamps
    end
    add_index :term_registrations, [:user_id, :term_id], unique: true
  end
end
