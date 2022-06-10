class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, 
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_and_belongs_to_many :organisations
  has_many :teams, through: :organisations
end
