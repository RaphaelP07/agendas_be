class Team < ApplicationRecord
  belongs_to :organisation
  has_and_belongs_to_many :users
end
