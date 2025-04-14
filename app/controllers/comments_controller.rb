class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to request.referer
    else
      redirect_to request.referer, alert: "Comment failed"
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :commenter, :comment_date, :event_id)
  end
end
