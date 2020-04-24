class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :listings
  has_many :destinations, through: :listings

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: {maximum: 20}
end
