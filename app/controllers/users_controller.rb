class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])

  	if @user.save
      sign_in @user
  		#handle successful save
  		flash[:success] = "Welcome! Your account has been created!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end
end
