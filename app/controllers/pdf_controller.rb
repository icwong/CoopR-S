class PdfController < Prawn::Document
    
    def initialize(job_a, job_b)
        super(top_margin: 70)
        @job_one = job_a
        @job_two = job_b
        header
        table_content
    end
    
    # TITLE
    def header
        text "Job comparison", size: 32, style: :bold, :align => :center
    end
    
    # Table Design
    def table_content
        move_down 20
        table product_rows do
           row(0).font_style = :bold
           self.header = true
           self.row_colors = ['DDDDDD', 'FFFFFF']
           columns(1..3).align = :left
           
       end 
    end
    
    # Table Information
    def product_rows
        [   
            ["OWNER", @job_one.owner_name.strip_tags, @job_two.owner_name.strip_tags], 
            ["TYPE" , @job_one.type.strip_tags, @job_two.type.strip_tags], 
            ["DESCRIPTION", @job_one.body.strip_tags, @job_two.body.strip_tags]
        ] 
    end
end



class String
  def strip_tags
    ActionController::Base.helpers.strip_tags(self)
  end
end