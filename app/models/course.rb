class Course < ApplicationRecord
    belongs_to :user
    has_many :course_registrations, dependent: :destroy 
    has_many :users, through: :course_registrations
    has_many :terms, dependent: :destroy 
  end