class User < ApplicationRecord
  has_many :courses, dependent: :destroy 
  has_many :course_registrations, dependent: :destroy 
  has_many :terms, dependent: :destroy 
  has_many :term_registrations, dependent: :destroy 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  enum role:[:student, :teacher, :garant, :admin]
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :student
  end
  attr_accessor :current_password
end