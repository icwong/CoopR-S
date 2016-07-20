class MainController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @uid = params[:id]
    @type = params[:type]
    if @uid == nil && @type == nil
      @posts = Post.all.order(id: :asc)
    elsif @uid != nil && @type == nil
      @posts = Post.where("owner = ?", @uid)
    elsif @uid == nil
      @posts = Post.where("type = ?", @type)
    else
      @posts = Post.where("owner = ? AND type = ?", @uid, @type)
    end
    
    respond_to do |format|
      format.html
      format.pdf do
        pdf = JobcomparisonPdf.new(@posts)
        send_data pdf.render, filename: 'Postings.pdf', type: 'application/pdf'
      end
    end
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
