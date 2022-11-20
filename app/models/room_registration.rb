class RoomRegistration < ApplicationRecord
    belongs_to :room
    belongs_to :term
  end