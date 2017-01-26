class PostsController < ApplicationController
  http_basic_authenticate_with name: "brad", password: "1234", except: [:index, :show]
	def index
      @posts = Post.all
      @p1 = Var.new
	end

	def show
		@post = Post.find(params[:id])
		@p1 = Var.new
  end

	def new
		@post = Post.new
		@posts = Post.all
	end

	def create
		#render plain: params[:post].inspect
		@post = Post.new(post_params)
		if@post.save
		redirect_to @post
    else
      render 'new'
    end
	end

	def edit
		@post = Post.find(params[:id])
		@p1 = Var.new
	end	

	def update 
		@post = Post.find(params[:id])

		if(@post.update(post_params))
			redirect_to @post
    	else
      		render 'edit'
    	end
	end	

	def destroy 
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to home_path
	end


	private def post_params
		params.require(:post).permit(:title, :body, :date, :pr_1_mpa, :pr_1_p, :pr_28_mpa, :pr_28_p, :pr_pr_mpa, :pr_pr_p, :mark)
  end
end
