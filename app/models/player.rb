class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # DB Relations
  has_many :playerships, dependent: :destroy
  has_many :games, through: :playerships

  # Validations
  validates :username, presence: true
end
