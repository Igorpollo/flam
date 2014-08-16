class CommentsController < ApplicationController
	def comment_params
      params.require(:comment).permit(:user_id, :photo_id, :body)
    end
end
