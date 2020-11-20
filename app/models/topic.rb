class Topic < ApplicationRecord

    validates :content, presence:true
    validates :title, presence:true
    validates :category, presence:true
    enum category: %i[Actualité Loisir Sport Mode Tourisme Politique Voyage Sexe Cuisine]

end