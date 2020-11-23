class FavoritesController < ApplicationController
    def create
       favorite = current_user.favorites.create(topic_id: params[:topic_id])
       flash[:success] = "Vous avez ajouté #{favorite.topic.title} à vos sujets favorit"
       redirect_to topic_path(favorite.topic.id)
   end

   def destroy
       favorite = current_user.favorites.find_by(id: params[:id]).destroy
       flash[:success] = "#{favorite.topic.title} n'est plus dans vos favorites"
       redirect_to topic_path(favorite.topic.id), notice: "The #{favorite.topic.user.name}'s  post is removed from your favorites"
   end

   def index
       @favorite = current_user.favorites.all
       @topic=Topic.all
   end
end
