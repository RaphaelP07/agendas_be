class Organisation < ApplicationRecord
  has_and_belongs_to_many :users
  has_many(
    :teams,
    dependent: :destroy
  )
  has_many(
    :meetings,
    dependent: :destroy
  )
  belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'

  validates :name, uniqueness: true
  validates :link, uniqueness: true
end
