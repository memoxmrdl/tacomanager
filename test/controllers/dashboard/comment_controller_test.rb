require "test_helper"

describe Dashboard::CommentController do
  let(:params) { { comment: 'Hello it is good' } }

  it 'should create a comment with valid params' do
    login_user

    xhr :post, :create, establishment_id: 100, comment: params

    must_response_with :success
    must_render_template :create
  end

  it 'should create a comment with invalid params' do
    login_user

    invalid_params = params.merge({ comment: '' })
    xhr :post, :create, establishment_id: 100, comment: invalid_params

    must_response_with :success
    must_render_template :create
  end
end
