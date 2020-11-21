class TopicsController < ApplicationController
     # collbacks
    before_action :authenticate_user!, only:%i[new edit destroy]
    before_action :set_topic, only: [:show, :edit, :update, :destroy]
    before_action :user_check, only: %i[edit destroy]

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
      @comments = @topic.comments
      @comment = @topic.comments.build
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
    def user_check
     unless current_user.id == @topic.user.id 
      flash[:success] = 'acces deny'
     end
    end
    # vérifier que l'utilisateur connecté est le propriétaire

    # empêcher à l'utilisateur de publier ou éditer ou supprimer sans être connecter ou s'il n'est pas propiétaire vérifier que l'utilisateur est connecté
    
end
