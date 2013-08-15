class Dashboard::CommentController < DashboardController
  def create
    @establishment = Establishment.find_by_id params[:establishment_id]

    @comment = Comment.new comment_params
    @comment.establishment = @establishment
    @comment.user_id = current_identity.user.id
    @comment.save

    redirect_to dashboard_establishment_path(id: @establishment.id) 
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
