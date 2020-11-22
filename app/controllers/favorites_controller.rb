class FavoritesController < ApplicationController
    def index
        
    end
    def create 
        favorite = current_user.favorites.create(topic_id: params[:topic_id]) 
        flash[:success] = "Merci pour votre contribution à #{favorite.topic.title}" 
        redirect_to topics_url, notice: "The #{favorite.topic.user.name}'s post  is added to your favorites"
    end 
    
    def destroy 
        favorite = current_user.favorites.find_by(id: params[:id]).destroy 
        redirect_to topics_url, notice: "The #{favorite.topic.user.name}'s  post is removed from your favorites"
    end 

    def show
     @favorite = current_user.favorites.all if logged_in?
    end
end
