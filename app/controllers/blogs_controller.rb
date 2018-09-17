class BlogsController < ApplicationController
  
  before_action :move_to_index, except: [:index, :show]
  
  def index
    @blogs = Blog.includes(:user).order("created_at DESC")
  end
  
  def create
    Blog.create(content: tweet_params[:content], user_id: current_user.id)
    redirect_to action: 'index'
    
  end
  
  def new
    @blog = Blog.new
  end
  
  def show
    @blog = Blog.find(params[:id])
  end
  
  def edit
    @blog = Blog.find(params[:id])
  end
  
  def update
    blog = Blog.find(params[:id])
    if blog.user_id == current_user.id
      blog.update(tweet_params)
    end
    redirect_to action: :index
    
  end
  
  
  
  def destroy
    blog = Blog.find(params[:id])
    if blog.user_id == current_user.id
      blog.destroy 
    end
    redirect_to action: :index
    
  end
  
  
  private
  
  def tweet_params
    params.require(:blog).permit(:content)
  end
  
  def move_to_index
      redirect_to action: :index unless user_signed_in?
  end
  
end
