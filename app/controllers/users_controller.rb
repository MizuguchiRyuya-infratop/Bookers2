class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@books = @user.books
		@book = Book.new
	end
end
