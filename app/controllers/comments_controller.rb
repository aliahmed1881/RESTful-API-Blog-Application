class CommentsController < ApplicationController
  before_action :authenticate_user!
	before_action :set_comment, only: [:show,:update, :destroy]


	def index
	     @comments = Comment.all 
	end

	def show
	    @comment 
	end

        def create
            return if @post.nil?
            comment = post.comments.create(comment_params.merge(user_id: current_user.id))
            respond_with post, comment
        end


        def update
  	    if current_user.id == @comment.user_id 
  		respond_to do |format|
      		     if @comment.update(comment_params)
      		           format.json { render :show, status: :ok, location: @comment}
      		     else
      		           format.json { render json: @comment.errors, status: :unprocessable_entity }
      		     end
    		  end
  	   end
       end

  
 	def destroy
  	  if current_user.id == @comment.user_id
                @comment.destroy
            respond_to do |format|
                format.json { head :no_content }
             end
          end
         end
 


private

	def set_comment
               @comment = Comment.find(params[:id])
         end

         def comment_params
             params.require(:comment).permit(:body)
         end

end
