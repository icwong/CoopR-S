class MainController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @uid = params[:id]
    @sort_by = 'id asc'
    if params[:sort_by] != nil
      @sort_by = params[:sort_by].to_s + ' asc'
    end

    if params[:cdate] != nil
      @cdate = DateTime.parse( params[:cdate] )
    end

    @announcements = Post.where("type = ''").order(@sort_by)
    if @uid == nil && @cdate == nil
      @reviews = Post.where("type = 'Review'").order(@sort_by)
      @promotions = Post.where("type = 'Promotion'").order(@sort_by)
    elsif @uid != nil && @cdate == nil
      @reviews = Post.where("type = 'Review' AND owner = ?", @uid).order(id: :asc)
      @promotions = Post.where("type = 'Rromotion' AND owner = ?", @uid).order(id: :asc)
    elsif @uid == nil
      @reviews = Post.where("type = 'Review' AND updated_at > ? AND updated_at < ?", @cdate, @cdate + 1.days).order(id: :asc)
      @promotions = Post.where("type = 'Promotion' AND updated_at > ? AND updated_at < ?", @cdate, @cdate + 1.days).order(id: :asc)
    else
      @reviews = Post.where("type = 'Review' AND owner = ? AND updated_at > ? AND updated_at < ?",
                                               @uid, @cdate, @cdate + 1.days).order(id: :asc)
      @promotions = Post.where("type = 'Promotion' AND owner = ? AND updated_at > ? AND updated_at < ?",
                                               @uid, @cdate, @cdate + 1.days).order(id: :asc)
    end
    

  end

  def filter_by_onwer
    # @posts = Post.all.where("owner = ?", params[:id])
    
    @posts = Post.all.order(id: :asc)
    @uid = params[:id]
  end

  def dummy
  end

  def warning
  end


  def editor
  end

  def compare
    @job_one = Post.find(params[:j1])
    @job_two = Post.find(params[:j2])

    respond_to do |format|
      format.html
      format.pdf do
        pdf = PdfController.new(@job_one, @job_two)
        send_data pdf.render, filename: 'Posts.pdf', type: 'application/pdf'
      end
    end
  end

  def has_preference

  end

  def has_address
    if user_signed_in?
      @preference = Preference.find_by user_id: current_user.id
      if !@preference.nil? && !@preference.latitude.nil?
        return true
      end
    end
    return false
  end

  def get_distance( user_id )
    @him = Preference.find_by user_id: user_id
    if !@him.nil? && !@him.latitude.nil?
      @lat_a = @preference.latitude.to_f
      @lng_a = @preference.latitude.to_f
      @lat_b = @him.latitude.to_f
      @lng_b = @him.longitude.to_f
      return Math.sqrt( ( @lat_b - @lat_a)**2 + ( @lng_b - @lng_a)**2 ).round(0)
    end
    return "N/A"
  end

  helper_method :has_address, :get_distance
end
