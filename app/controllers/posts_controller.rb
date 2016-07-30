class PostsController < ApplicationController
	def index
		@posts = Post.all
	end
	def new
		@post = Post.new
	end
	def create
		@post = Post.new(post_params)
		if @post.save
			redirect_to root_path
		else
			render "new"
		end
	end
	def edit
		@post = Post.find(params[:id])
	end
	def update
		@post = Post.find(params[:id])
		if @post.update(post_params)
			redirect_to posts_path
		else
			render "edit"
		end

	end
	def show
		@post = Post.find(params[:id])
		@comment = Comment.new(post_id: @post.id)
	end
	def destroy
		@post = Post.find(params[:id])
		if !@post.destroy.blank?
			flash[:message] = "delete succesfull"
			redirect_to root_path
		else
			flash[:message] = "oops something went wrong"
			redirect_to root_path
		end
	end

	def comment_create
		@comment = Comment.new
		@comment.body = params[:comment][:body]
		@comment.post_id = params[:post_id]
		@comment.save
		respond_to do |format|
		  format.js
		  format.html
		end
	end

	def comment_edit
		@comment = Comment.find(params[:comment_id])
		respond_to do |format|
			format.js
			format.html
		end
	end

	def comment_update
		@comment = Comment.find(params[:comment_id])
		@comment.body = params[:comment][:body]
		if @comment.save
			redirect_to post_path(@comment.post_id)
		else
			render 'comment_edit'
		end
	end
	
	def comment_destroy
		@comment = Comment.find(params[:id])
		post_id = @comment.post_id
		if @comment.destroy
			redirect_to post_path(post_id)
		else
			render 'show'
		end

	end

	def image_edit
		@post = Post.find(params[:id])
		respond_to do |format|
		  format.js
		  format.html
		end
	end
	private

		def post_params
			params.require(:post).permit(:title , :body , :image)
		end
end

