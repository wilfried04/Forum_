class TopicsController < ApplicationController
     # collbacks
    before_action :authenticate_user!, only: %i[new edit destroy]
    before_action :set_topic, only: [:show, :edit, :update, :destroy]
    before_action :user_check, only: %i[edit destroy]
    # has_many :favorite_users, through: :favorites, source: :user
    # belongs_to :user

    def index
        if params[:title]
          @topic= Topic.where(["title LIKE ?", "%#{params[:title]}%"])
       elsif params[:sort_my_topic]
         @topic= current_user.topic
       elsif params[:sort_actuality]
         @topic= Topic.where(["category=0"])
       elsif params[:sort_losir]
         @topic= Topic.where(["category=1"])
       elsif params[:sort_sport]
         @topic= Topic.where(["category=2"])
       elsif params[:sort_mode]
         @topic= Topic.where(["category=3"])
       elsif params[:sort_tourism]
         @topic= Topic.where(["category=4"])
       elsif params[:sort_politique]
         @topic= Topic.where(["category=5"])
       elsif params[:sort_voyage]
         @topic= Topic.where(["category=6"])
       elsif params[:sort_sexe]
         @topic= Topic.where(["category=7"])
       elsif params[:sort_cuisine]
         @topic= Topic.where(["category=8"])
       else
        @topic= Topic.all
      end
    end

    def new
      @topic = Topic.new
    end

    def create
        @topic = Topic.new(topic_params)
        # id user a l'enregistrement
        @topic.user_id = current_user.id
        if @topic.save
            flash[:success] = I18n.t('topic.create')
            redirect_to topics_path
        end
    end

    def edit

    end

    def show
      @favorite = @topic.favorites.find_by(topic_id: @topic.id)
      @comments = @topic.comments
      @comment = @topic.comments.build
    end

    def update
      if @topic.update(topic_params)
      flash[:success] =  I18n.t('topic.update')
      redirect_to topics_path
    else
      render :edit
    end
    end
    def destroy
      @topic.destroy
      flash[:success] = I18n.t('topic.destroy')
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
      flash[:success] = I18n.t('topic.user_check')
     end
    end
    # vérifier que l'utilisateur connecté est le propriétaire

    # empêcher à l'utilisateur de publier ou éditer ou supprimer sans être connecter ou s'il n'est pas propiétaire vérifier que l'utilisateur est connecté

end
