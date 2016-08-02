class MainController < ApplicationController
  skip_before_action :authenticate_user!
  helper_method :has_address, :get_distance, :get_rating, :has_rating

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
      @promotions = Post.where("type = 'Promotion' AND owner = ?", @uid).order(id: :asc)
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
    @job_one = Job.find_by id: params[:j1]
    @job_two = Job.find_by id: params[:j2]

    respond_to do |format|
      format.html
      format.pdf do
        pdf = PdfController.new(@job_one, @job_two)
        send_data pdf.render, filename: 'J' + params[:j1] + 'vsJ' + params[:j1] + '.pdf', type: 'application/pdf'
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
      @lng_a = @preference.longitude.to_f
      @lat_b = @him.latitude.to_f
      @lng_b = @him.longitude.to_f

      # puts "\n\n\n" + @lat_a.to_s
      # puts "\n" + @lat_b.to_s
      # puts "\n" + @lng_a.to_s
      # puts "\n" + @lng_b.to_s
      # puts "\n" + ( @lat_b - @lat_a).to_s
      # puts "\n" + (( @lat_b - @lat_a)**2).to_s
      # puts "\n" + ( @lng_b - @lng_a).to_s
      # puts "\n" + (( @lng_b - @lng_a)**2).to_s
      
      return Math.sqrt( ( @lat_b - @lat_a)**2 + ( @lng_b - @lng_a)**2 ).round(0)
    end
    return "N/A"
  end

  def has_rating
    if user_signed_in?
      @preference = Preference.find_by user_id: current_user.id
      if !@preference.nil?
        return true
      end
    end
    return false
  end

  def get_rating( that )
    @job = Job.find_by id: that.id
    @him = Preference.find_by user_id: current_user.id
    
    if !@him.nil? && !@job.nil?
      @formula = @him.get_formula
      @coefficients = @formula.scan( /[-+]?[0-9]*\.?[0-9]+/ )

      @far = get_distance( @job.offered_by )
      if @far.nil? || @far == "N/A"
        @rate = 0
      else
        @rate = Math.sqrt( @far ).round(0) * @coefficients[0].to_f
      end

      if !@job.working_hours.nil?
        @rate = @rate + @job.working_hours * @coefficients[1].to_f
      end

      if !@job.work_day.nil?
        @rate = @rate + @job.work_day * @coefficients[2].to_f
      end

      if !@job.salary.nil?
        @rate = @rate + @job.salary * @coefficients[3].to_f
      end

      return @rate.round(0)
    end
    return "N/A"
  end

end
