class FavoritesController < ApplicationController
    def create 
        favorite = current_user.favorites.create(topic_id: params[:topic_id]) 
        flash[:success] = "Merci pour votre contribution à #{favorite.topic.name}" 
        redirect_to topic_path(favorite.topic.id)
    end 
    
    def destroy 
        favorite = current_user.favorites.find_by(id: params[:id]).destroy 
        flash[:success] = "Vous n'êtes plus contributeur de #{favorite.topic.name}" 
    end 
end
