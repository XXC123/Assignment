module ApplicationHelper
    def load_head_data
        @categories = Category.all
        @locations  = Location.all
    end

    def full_title(page_title = "")
        base_title = "Welcome to your Course App"
        if (page_title.empty?)
            base_title
        else
            page_title + "|" + base_title
        end
    end

end
