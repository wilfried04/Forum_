class TopicsController < ApplicationController
     # collbacks
    before_action :set_topic, only: [:show, :edit, :update, :destroy]
    before_action :set_topic, only: %i[show edit update destroy]
    #before_action :login_check, only: %i[new edit destroy]
    before_action :user_check, only: %i[edit destroy]
    #before_action :topic_check, only: %i[new create]
    def index
     @topic= Topic.all
    end

    def new
      @topic = Topic.new
    end

    def create
        @topic = Topic.new(topic_params)
        # id user a l'enregistrement
        @topic.user_id = current_user.id 
        if @topic.save
            flash[:success] = 'Post successfully create'
            redirect_to topics_path
        end
    end

    def edit

    end

    def show

    end
    def update
      if @topic.update(topic_params)
      flash[:success] = 'Post successfully update'
      redirect_to topics_path
    else
      render :edit
    end
    end
    def destroy
      @topic.destroy
      flash[:success] = 'Post successfully destroy'
      redirect_to topics_path
    end
    private
    def topic_params
      params.require(:topic).permit(:title,:content,:category)
    end
    def set_topic
      @topic=Topic.find(params[:id])
    end
    # vérifier que l'utilisateur connecté est le propriétaire
    def user_check
      redirect_to topics_path, 
      notice:('access deny') 
      unless current_user == @topic.user_id
      end
    end

 
    # empêcher à l'utilisateur de publier ou éditer ou supprimer sans être connecter ou s'il n'est pas propiétaire vérifier que l'utilisateur est connecté
    def login_check
      redirect_to new_user_registration_path, 
      notice:('you are not login, please login or create new accompt') 
      unless user_signed_in?
      end
    end
end
