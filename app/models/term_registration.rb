class TermRegistration < ApplicationRecord
    belongs_to :user
    belongs_to :term
  end