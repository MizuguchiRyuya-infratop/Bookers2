class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
		@users = User.all
		@new_book = Book.new
	end

	def show
		@user = User.find(params[:id])
		@books = @user.books
		@new_book = Book.new
	end

	def edit
		@user = User.find(params[:id])
		redirect_not_match_user(@user.id)
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:success] = 'You have updated user successfully.'
			redirect_to user_path(@user.id)
		else
			render 'edit'
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end

	def redirect_not_match_user(user_id)
		redirect_to user_path(current_user.id) if current_user.id != user_id
	end
end
