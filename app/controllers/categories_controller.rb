class CategoriesController < ApplicationController
	def show
		sql = "select * from courses where category='" + params[:id].to_s + "';"
	    @courses = ActiveRecord::Base.connection.execute(sql)
	    @category = Category.find(params[:id])
	end
	
	def new
		@category = Category.new
	end
	
    def create
        @category = Category.create(name: params[:name])
        if (@category.save)
            flash[:success] = "Create Category Succeffully!"
            redirect_to category_url(@category)
        else
            render "new"
        end
    end
    
    def category_params
        params.require(:category).permit(:name, :user)
    end

end
