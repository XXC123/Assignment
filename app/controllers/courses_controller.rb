class CoursesController < ApplicationController

    def show
        sql = "select * from courses where courses.id=" + params[:id].to_s
        @course = ActiveRecord::Base.connection.execute(sql).first
        if (@course)
            user = @course.fetch("user")
            @user = User.find(user)  
        
            locs = @course.fetch("location")

            @location = ""
            locs.split(",").each do |item|
                if item.to_i <= 0
                    next
                end
                sql = "select * from locations where id=" + item

                loc = ActiveRecord::Base.connection.execute(sql).first
                if !loc
                    next
                end
                n = loc.fetch("name")
                if !n
                    next
                end
                @location = @location + (n + ", ")
            end
            
            @category = ""
            cats = @course.fetch("category")
            cats.split(",").each do |item|
                if item.to_i < 0
                    next
                end
                sql = "select name from categories where id=" + item
                cat = ActiveRecord::Base.connection.execute(sql).first
                if !cat
                    next
                end
                n = cat.fetch("name")
                if !n
                    next
                end
                @category = @category + (n + ", ")
            end
        end
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

    def edit
       @categories = Category.all
       @locations  = Location.all
       
        sql = "courses.id=" + params[:id].to_s
        @course = Course.where(sql)
        @course = @course.first
        if (@course)
            user = @course.user
            @user = User.find(user)  
        
            locs = @course.location

            @location = Array.new
            locs.split(",").each do |item|
                if item.to_i <= 0
                    next
                end
                @location.push(item)
            end
            
            @category = Array.new
            cats = @course.category
            cats.split(",").each do |item|
                if item.to_i <= 0
                    next
                end
                
                @category.push(item)
            end
        end
    end


    def update
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

        attributes = Hash.new
        @thecourse = Course.find(params[:id])
        if params[:course][:name] != ""
            attributes[:name] = params[:course][:name]
        end
        
        if params[:course][:prerequisite] != ""
            attributes[:prerequisite] = params[:course][:prerequisite]
        end
        
        if params[:course][:desc] != ""
            attributes[:desc] = params[:course][:desc]
        end
        img = params[:course][:img_name]
        if img && img.original_filename != ""
            attributes[:img_name] = params[:course][:img_name].original_filename
        end
        
        if (locs != "")
            attributes[:location] = locs
        end
        
        if cats != ""
            attributes[:category] = cats
        end

        if (@thecourse.update_attributes(attributes))
            flash[:success] = "Create course succefully!"
            redirect_to course_url(@thecourse)
        else
            render "new"
        end
    end
    
    def course_params
       params.require(:course).permit(:name, :prerequisite, :img_name, :desc)
    end
end
