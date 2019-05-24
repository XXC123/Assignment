class CategoriesController < ApplicationController
	def show
		sql = "select * from courses where instr(category, '" + params[:id].to_s + "') > 0;"
	    @courses = ActiveRecord::Base.connection.execute(sql)

	    puts @courses
	    
	    @category = Category.find(params[:id])
	    
	    puts @category
	end
	
	def new
		@category = Category.new
	end

    def create
        if current_user
            u = current_user.id
        else
            u = 0
        end
        
        @category = Category.create(name: params[:category][:name], user: u)
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
