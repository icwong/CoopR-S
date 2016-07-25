class ResumesController < ApplicationController
    def index
    end
    
    def new
        @resume = Resume.new
    end
    
    def create
        @resume = Resume.new(resume_params)
        if @resume.save
            redirect_to show_resume_path(@resume)
        else 
            flash[:danger] = @resume.errors.full_messages.to_sentence
            render 'new'
        end
    end
    
    def show
        @resume = Resume.find(params[:id])
        respond_to do |format|
            format.html
            format.pdf do
                render  :pdf => "resume.pdf",  :template => 'resumes/show.html.erb'   # Excluding ".pdf" extension.
            end
        end
    end
    
    def search
        @resumes = Resume.search(params)
    end
    
    private
    def resume_params
        params.require(:resume).permit(:name, :summary, :email,:gitweb, :phone,
                                       :workname, :workrole, :workwhen, :workloc, :workinfo,
                                       :projtitle, :projrole, :projwhen,
                                       :edudeg, :eduloc, :eduuni, :eduwhen, :gpa, :skill)
                                       
                                           
    end
end
    
    