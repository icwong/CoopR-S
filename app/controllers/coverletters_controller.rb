class CoverlettersController < ApplicationController
    
    def index
    end
    
    def new
        @coverletter = Coverletter.new
    end
    
    def create
        @coverletter = Coverletter.new(resume_params)
        if @coverletter.save
            redirect_to show_coverletter_path(@coverletter)
        else 
            flash[:danger] = @coverletter.errors.full_messages.to_sentence
            render 'new'
        end
    end
    
    def show
        @coverletter = Coverletter.find(params[:id])
    end
    
    private
    def coverletter_params
        params.require(:resume).permit(:name, :summary, :email,:gitweb, :phone)
    end

    
end