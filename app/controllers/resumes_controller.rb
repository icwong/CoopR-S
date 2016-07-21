class ResumesController < ApplicationController
    before_action :authenticate_user!, only: [:create, :new]
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
    end
    
    def search
        @resumes = Resume.search(params)
    end
    
    private
        def resume_params
            params.require(:resume).permit(:name, :description, :address, :city,
                                           :state, :zipcode, :phone, :email)
        end

end


