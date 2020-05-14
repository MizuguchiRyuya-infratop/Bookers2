class BookCommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@book_comment = current_user.book_comments.create(book_comment_params)
		redirect_back(fallback_location: root_path)
	end

	def destroy
		redirect_not_match_user(current_user.id)
		@book_comment = BookComment.find_by(book_id: params[:book_id], user_id: current_user.id)
		@book_comment.destroy
		redirect_back(fallback_location: root_path)
	end

	private

	def book_comment_params
		params.require(:book_comment).permit(:body).merge(book_id: params[:book_id])
	end

	def redirect_not_match_user(user_id)
		redirect_to books_path if current_user.id != user_id
	end
end
