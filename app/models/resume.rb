class Resume < ActiveRecord::Base
    
    belongs_to :category
    # validates_presence_of :name
    # validates_presence_of :summary

    
end