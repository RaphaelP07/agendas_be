class Meeting < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :organisation
  has_many :videos
end
