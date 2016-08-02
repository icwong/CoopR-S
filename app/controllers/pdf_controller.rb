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
            ["OFFERED BY", @job_one.offered_name.strip_tags, @job_two.offered_name.strip_tags], 
            ["Work Day", @job_one.work_day.to_s.strip_tags, @job_two.work_day.to_s.strip_tags], 
            ["Hours per Week", @job_one.working_hours.to_s.strip_tags, @job_two.working_hours.to_s.strip_tags], 
            ["SALARY", @job_one.salary.to_s.strip_tags, @job_two.salary.to_s.strip_tags]
        ] 
    end
end



class String
  def strip_tags
    ActionController::Base.helpers.strip_tags(self)
  end
end