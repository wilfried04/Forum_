class TopicsController < ApplicationController
    before_action :set_topic, only: [:show, :edit, :update, :destroy]
    def index
     @topic= Topic.all
    end

    def new
      @topic = Topic.new
    end

    def create
        @topic = Topic.new(topic_params)
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
end
