class Organisation < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :teams
  belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'

  validates :name, uniqueness: true
end
