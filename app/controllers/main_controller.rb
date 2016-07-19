class MainController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @posts = Post.all.order(id: :asc)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = JobcomparisonPdf.new(@posts)
        send_data pdf.render, filename: 'Postings.pdf', type: 'application/pdf'
      end
    end
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