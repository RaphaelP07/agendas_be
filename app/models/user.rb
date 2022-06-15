class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, 
         :jwt_authenticatable, 
         :omniauthable, 
         omniauth_providers: [:google_oauth2],
         jwt_revocation_strategy: self

  has_and_belongs_to_many :organisations
  has_many :organisations, foreign_key: 'admin_id'
  has_many :teams, through: :organisations
  has_and_belongs_to_many :meetings
  has_many :messages, foreign_key: 'sender_id'
end
