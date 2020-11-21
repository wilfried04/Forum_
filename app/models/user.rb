class User < ApplicationRecord
  validates :email , presence: true , uniqueness: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # mount_uploader :avatar, AvatarUploader
  has_one_attached :avatar #  Avatar fonction
  has_many :topic, dependent: :destroy
  has_many :comments, dependent: :destroy
  # Avatar
  def avatar_thumbnail 
    if avatar.attached? 
      avatar.variant(resize: "150x150!").processed 
    else "/default-avatar.jpg" 
    end 
  end

end
