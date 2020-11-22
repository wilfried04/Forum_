class Topic < ApplicationRecord
    belongs_to :user
    validates :content, presence:true
    validates :title, presence:true
    validates :category, presence:true
    enum category: %i[Actualité Loisir Sport Mode Tourisme Politique Voyage Sexe Cuisine]
    # comment fonction
    has_many :comments, dependent: :destroy
    #favorites function
    has_many :favorites, dependent: :destroy
    has_many :favorite_users, through: :favorites, source: :user

end
