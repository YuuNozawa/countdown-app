class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to request.referer, notice: "コメントが追加されました!"
    else
      Rails.logger.debug("保存失敗： #{@Comment.errors.full_messages.join(', ')}")
      redirect_to request.referer, alert: "コメントが追加できませんでした"
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :commenter, :comment_date, :event_id)
  end
end
