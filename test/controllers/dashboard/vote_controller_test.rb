require 'test_helper'

describe Dashboard::VoteController do
  let(:establishment) { establishments(:one) }
  let(:params_good) { { vote_good: true } }
  let(:params_bad) { { vote_bad: true  } }

  describe 'POST create' do
    it 'must add good point a establishment' do
      login_user

      xhr :post, :create, establishment_id: establishment.id, vote: params_good

      must_response_with :success
      must_render_template :create
    end

    it 'must add bad point an establishment' do
      login_user

      xhr :post, :create, establishment_id: establishment.id, vote: params_bad

      must_response_with :success
      must_render_template :create
    end
  end
end
