class CoursesController < ApplicationController

    def show
        sql = "select * from courses where id=" + params[:id].to_s
        @course = ActiveRecord::Base.connection.execute(sql).first   
    end
    
    def new
       @course = Course.new
       @categories = Category.all
       @locations  = Location.all
    end
    def index
        sql = "select * from courses;"
	    @courses = ActiveRecord::Base.connection.execute(sql)
    end

    def create
        @course = Course.new(course_params)
        
        
        @course.location = "10.01.01"
        @course.category = "1"
        
        
        
        
        if (@course.save)
            flash[:success] = "Create course succefully!"
            redirect_to course_url(@course)
        else
            render "new"
        end
    end
    
    
    def course_params
       params.require(:course).permit(:name, :prerequisite, :category, :location, :img_name, :desc)
    end
end
