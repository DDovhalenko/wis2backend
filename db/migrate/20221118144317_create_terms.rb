class CreateTerms < ActiveRecord::Migration[7.0]
  def change
    create_table :terms do |t|
      t.belongs_to :user
      t.belongs_to :course
      t.string :name
      t.string :term_type
      t.date :date
      t.time :time_start
      t.time :time_end
      t.integer :limit
      t.timestamps
    end
  end
end
