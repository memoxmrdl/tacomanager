class Dashboard::VoteController < DashboardController
  respond_to :js

  def create
    @establishment = Establishment.find_by_id params[:establishment_id]

    if params[:vote][:vote_good]
      @establishment.liked_by current_identity.user
    elsif params[:vote][:vote_bad]
      @establishment.downvote_from current_identity.user
    end

    respond_with @establishment
  end
end
