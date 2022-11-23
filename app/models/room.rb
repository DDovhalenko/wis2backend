class Room < ApplicationRecord
    has_many :room_registrations, dependent: :destroy 
  end