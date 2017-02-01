class CommentsController < ApplicationController
    http_basic_authenticate_with name: "a", password: "b", only: [:destroy]
   # def new
   # @post = Post.new
   # @posts = Post.all
 # end
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    redirect_to post_path(@post)
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end
  
  private def comment_params
    params.require(:comment).permit(:username, :body, :date, :pr_1_mpa, :pr_1_p, :pr_28_mpa, :pr_28_p, :pr_pr_mpa, :pr_pr_p, :mark)
  end

end
