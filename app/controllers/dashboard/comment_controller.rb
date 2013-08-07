class Dashboard::CommentController < DashboardController
  respond_to :js

  def create
    establishment = Establishment.find_by_id params[:establishment_id]

    @comment = Comment.new comment_params
    @comment.establishment = establishment

    @comment = nil unless @comment.save

    respond_with @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
