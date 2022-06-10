class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, 
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_and_belongs_to_many :organisations
  has_many :teams, through: :organisations
  has_and_belongs_to_many :meetings
  has_many :senders, class_name: 'Message', foreign_key: 'sender_id'
  has_many :receivers, class_name: 'Message', foreign_key: 'receiver_id'
end
