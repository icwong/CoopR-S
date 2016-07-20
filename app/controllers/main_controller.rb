class MainController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @posts = Post.all.order(id: :asc)
    @uid = params[:id]
  end

  def filter_by_onwer
    # @posts = Post.all.where("owner = ?", params[:id])
    @posts = Post.all.order(id: :asc)
    @uid = params[:id]
  end

  def dummy
  end


  def editor
  end

  def compare
    @job_one = Post.find(params[:j1])
    @job_two = Post.find(params[:j2])
  end
end
