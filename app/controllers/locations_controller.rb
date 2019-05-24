class LocationsController < ApplicationController
	def show
		sql = "select * from courses where INSTR(location,'" + params[:id].to_s + "') > 0;"
	    @courses = ActiveRecord::Base.connection.execute(sql)
	    @location = Location.find(params[:id])
	end
	
	def new
		@location = Location.new
	end
	
    def create
        @location = Location.new(location_params)
        if (@location.save)
            flash[:success] = "Create Location Succeffully!"
            redirect_to location_url(@location)
        else
            render "new"
        end
    end
    
    def location_params
        params.require(:location).permit(:name)
    end

end
