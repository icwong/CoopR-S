class PostsController < ApplicationController
  skip_before_action :authenticate_user!, :except => [:edit, :create, :new]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_status, only: [:edit, :update, :destroy]
  helper_method :has_address, :has_rating

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @can_edit = false
    if user_signed_in?
      @my_pre = Preference.find_by user_id: current_user.id
      @my_pro = Profile.find_by user_id: current_user.id
      @similars = find_similar
      if current_user.admin?
        @can_edit = true
      elsif current_user.editor? && @post.owner == current_user.id
        @can_edit = true
      end
    end
  end

  def find_similar
    @same_writer = Post(:all, :order => "updated_at desc", :limit => 100).where("owner = " + @post.owner )
    @same_writer = Job(:all, :order => "updated_at desc", :limit => 100).where("owner = " + @post.owner )

  end

  # GET /posts/new
  def new

    if !current_user.editor?
      # puts "\n\n  mm!  \n"
      redirect_to auth_path
    end
    @post = Post.new
    @job = Job.new
  end

  def check_status

    if !current_user.admin?
      if !current_user.editor?
        redirect_to auth_path
      elsif @post.owner != current_user.id
        redirect_to warning_path
        flash[:notice] = 'edit other user\'s post' 
      end
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @me = current_user
    if !@me.editor?
      redirect_to auth_path
    end

    @post = Post.new(post_params)

    @post.owner = @me.id
    if !@me.admin?
      if @me.type == 'Company'
        @post.type = 'Promotion'
      else
        @post.type = 'Review'
      end
    end
    
    @message = ""
    if @post.title.blank?
      @post.title = Faker::Lorem.sentence
      @message += " Random title was generated for the post."
    end
    if @post.body.blank?
      @post.body = Faker::Lorem.paragraphs
      @post.body.gsub! '["', '<p>'
      @post.body.gsub! '", "', '</p><p>'
      @post.body.gsub! '"]', '</p>'
      @message += " Random text was generated for the post."
    end
    
    respond_to do |format|
      if @post.save
        @jparams = job_params
        @jparams[:id] = @post.id
        @job = Job.new(@jparams)
        if @post.type = 'Promotion'
          @job.update( {:offered_by => @post.owner } )
        end
        format.html { redirect_to @post, notice: 'Post was successfully created.' + @message }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def has_location(that)
    if !that.nil?
      if !that.preference.nil?
        return that.preference.has_location
      end
    end
    return false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :type, :owner)
    end

    def job_params
      params.require(:post).require(:job).permit(:job_title, :offered_by, :working_hours, :work_day, :salary)
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


    def has_address
      if user_signed_in?
        @preference = Preference.find_by user_id: current_user.id
        if !@preference.nil? && !@preference.latitude.nil?
          return true
        end
      end
      return false
    end
end
