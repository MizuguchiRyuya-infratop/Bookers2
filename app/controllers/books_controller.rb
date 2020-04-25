class BooksController < ApplicationController
	before_action :authenticate_user!

	def index
		@books = Book.all
		@new_book = Book.new
		@user = User.find(current_user.id)
	end

	def show
		@book = Book.find(params[:id])
		@new_book = Book.new
		@user = User.find(current_user.id)
	end

	def create
		@new_book = Book.new(book_params)
		if @new_book.save
			flash[:success] = 'You have creatad book successfully.'
			redirect_to book_path(@new_book.id)
		else
			@books = Book.all
			render 'index'
		end
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		raise StandardError if current_user.id != @book.user.id
		if @book.update(book_params)
			redirect_to book_path(@book.id)
		else
			render 'edit'
		end
	end

	def destroy
		book = Book.find(params[:id])
		raise StandardError if current_user.id != book.user.id
		if book.destroy
			flash[:success] = 'successfully: 削除しました'
			redirect_to books_path
		else
			flash[:danger] = 'error: 削除できませんでした'
			redirect_to books_path
		end
	end

	private

	def book_params
		params.require(:book).permit(:title, :body).merge(user_id: current_user.id)
	end
end
