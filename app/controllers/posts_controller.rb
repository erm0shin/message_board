class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :show, :delete]

  # Index action to render all posts
  def index
    @posts = Post.all
  end

  # New action for creating post
  def new
    @post = Post.new
  end

  # Create action saves the post into database
  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Successfully created post!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Error creating new post!"
      render :new
    end
  end

  # Edit action retrives the post and renders the edit page
  def edit
  end

  # Update action updates the post with the new information
  def update
    if @post.email != current_user.email
      flash[:alert] = "Error updating post!"
    else
      if @post.update_attributes(post_params)
        flash[:notice] = "Successfully updated post!"
        #redirect_to post_path(@posts)
        redirect_to root_path
      else
        flash[:alert] = "Error updating post!"
        render :edit
      end
    end
  end

  # The show action renders the individual post after retrieving the the id
  def show
  end

  # The destroy action removes the post permanently from the database
  def destroy
    @post = Post.find(params[:id])
    if @post.email != current_user.email
      flash[:alert] = "Error updating post!"
    else
      if @post.destroy
        flash[:notice] = "Successfully deleted post!"
        redirect_to root_path
      else
        flash[:alert] = "Error updating post!"
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :email, :body)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end