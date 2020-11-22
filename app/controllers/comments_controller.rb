class CommentsController < ApplicationController
    before_action :set_topic, only: %i[create edit update destroy]
    before_action :login_check, only: %i[create edit destroy]
    def create
      @comment = @topic.comments.build(comment_params)
      @comment.user_id = current_user.id
      respond_to do |format|
        if @topic.save
          format.js { render :index }
        else
          format.html { redirect_to topic_path(@topic), notice: "Couldn't post..." }
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
            flash.now[:notice] = 'Commentaire mis a jour'
            format.js { render :index }
          else
            flash.now[:notice] = 'commentaire non mis à jour'
            format.js { render :edit_error }
          end
        end
      end
    
    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      respond_to do |format|
        flash.now[:notice] = 'Comment deleted'
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
        redirect_to new_user_session_path, notice: 'you are not login, please login or create new accompt'
      end
    end
  end