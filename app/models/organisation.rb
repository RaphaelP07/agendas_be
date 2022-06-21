class Organisation < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :teams
  has_many :meetings
  belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'

  validates :name, uniqueness: true
  validates :link, uniqueness: true
end
