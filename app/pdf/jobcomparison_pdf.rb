class JobcomparisonPdf < Prawn::Document
    
    def initialize(posts)
        super(top_margin: 70)
        @posts = posts
        header
        table_content
    end
    
    # TITLE
    def header
        text "REVIEW - PROMOTION POSTINGS", size: 32, style: :bold, :align => :center
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
        [["OWNER", "TYPE" , "DESCRIPTION"]] +
        @posts.map do |post|
            [post.owner_name , post.type, post.body]
        end
    end
end