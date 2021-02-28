class PostsController < ApplicationController
  before_action :authenticate_user!
	before_action :set_post, only: [:show,:update, :destroy]


	def index
		@posts = Post.all 
		 
	end

	def show
			@psot 
	end

	def create
    respond_with Post.create(post_params.merge(user_id: current_user.id, author: current_user.username))
 	end



  def update
  	if current_user.id == @post.user_id
  			respond_to do |format|
      		if @post.update(post_params)
      		  format.json { render :show, status: :ok, location: @post}
      		else
      		  format.json { render json: @post.errors, status: :unprocessable_entity }
      		end
    		end
  	end

  end

  
 	def destroy
  	if current_user.id == @post.user_id
     
        @post.destroy
        respond_to do |format|
          format.json { head :no_content }
        end
    end
  end
 


private


	def set_post
      @post = Post.find(params[:id])
  end
  def post_params
    params.require(:post).permit(:title, :body,:all_tags )
  end

end