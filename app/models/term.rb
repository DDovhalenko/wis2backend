class Term < ApplicationRecord
    belongs_to :user
    has_many :term_registrations
    has_many :users, through: :term_registrations
    has_many :room_registrations
    has_many :rooms, through: :room_registrations
    belongs_to :course
  end