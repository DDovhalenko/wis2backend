class CreateRoomRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :room_registrations do |t|
      t.belongs_to :term
      t.belongs_to :room
      t.date :date
      t.time :time_start
      t.time :time_end
      t.timestamps
    end
  end
end
