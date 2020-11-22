class User < ApplicationRecord

  validates :email , presence: true , uniqueness: true
  validates :name , presence: true , uniqueness: true
  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google facebook]

  has_many :topic, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # Avatar
  def avatar_thumbnail
      if avatar.present?
        avatar.url
      else
        '/default-avatar.png'
      end
    end



  # Google OAuth
  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_google(auth)
   user = User.find_by(email: auth.info.email)
   user ||= User.new(email: auth.info.email,
                     name: auth.info.name,
                     provider: auth.provider,
                     uid: auth.uid,
                     password: Devise.friendly_token[0, 20])
   user.save
   user
 end
 #facebook OAuth
 def self.find_for_facebook(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.email = auth.info.email
     user.password = Devise.friendly_token[0, 20]
     user.name = auth.info.name # assuming the user model has a name
   end
end
end
