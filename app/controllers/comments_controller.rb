class CommentsController < ApplicationController

    before_action :authenticate_user!, only: %i[create edit update destroy]
    before_action :set_topic, only: %i[create edit update destroy]

    def create
      @comment = @topic.comments.build(comment_params)
      @comment.user_id = current_user.id
      respond_to do |format|
        if @topic.save
          format.js { render :index }
        else
          format.html { redirect_to topic_path(@topic), notice: I18n.t('comment.not_save') }
        end
      end
    end

    def edit
        @comment = @topic.comments.find(params[:id])
        respond_to do |format|
          format.js { render :edit }
        end
      end

      def update
        @comment = @topic.comments.find(params[:id])
        respond_to do |format|
          if @comment.update(comment_params)
            flash.now[:notice] = I18n.t('comment.update')
            format.js { render :index }
          else
            flash.now[:notice] = I18n.t('comment.not_update')
            format.js { render :edit_error }
          end
        end
      end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      respond_to do |format|
        flash.now[:notice] = I18n.t('comment.destroy')
        format.js { render :index }
      end
   end

    private

    def comment_params
      params.require(:comment).permit(:topic_id, :comment)
    end

    def set_topic
      @topic = Topic.find(params[:topic_id])
    end

    def login_check
      unless user_signed_in?
        redirect_to new_user_session_path, notice: I18n.t('comment.login_check')
      end
    end
  end
