class UsersController < ApplicationController
 
 	def new
    	@user = User.new
  	end

  	def create
    	@user = User.new(user_params)
    		if @user.save
        		log_in @user
    			flash[:success] = "Bienvenue sur ce site!"
     			redirect_to @user
    		else
    			flash.now[:danger] = "Mauvaise manipulation!"
      			render 'new'
    		end
  	end

  	def show
  		@user = User.find(params[:id])
  	end

  	  private

  	def user_params
    	params.require(:user).permit(:name, :password)
  	end


end
