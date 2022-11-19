class Term < ApplicationRecord
    belongs_to :user
    has_many :term_registrations
    has_many :users, through: :term_registrations
    belongs_to :course
  end