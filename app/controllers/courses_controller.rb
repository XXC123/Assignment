class CoursesController < ApplicationController

    def show
        sql = "select * from courses where courses.id=" + params[:id].to_s
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
        locs = ""
        params[:location].each do |key, value|
            if (value == "on")
                locs = locs + (key + ",")
            end
        end

	    cats = ""
	    params[:category].each do |key, value| 
	        if (value == "on")
	            cats = cats + (key + ",")
	        end
	    end

        @course = Course.create(user: current_user.id.to_s, name: params[:course][:name], prerequisite: params[:course][:prerequisite], desc: params[:course][:desc], img_name: params[:course][:img_name].original_filename, location: locs, category: cats)

        if (@course.save)
            flash[:success] = "Create course succefully!"
            redirect_to course_url(@course)
        else
            render "new"
        end
    end

    def course_params
       params.require(:course).permit(:name, :prerequisite, :img_name, :desc)
    end
end
