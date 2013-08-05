require 'test_helper'

describe HomeController do
  it 'get success index' do
    get :index

    must_response_with :success
  end
end
