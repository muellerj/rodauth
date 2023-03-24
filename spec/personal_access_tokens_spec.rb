require_relative 'spec_helper'

describe 'Rodauth login feature' do
  it "should allow access using a personal access token" do
    rodauth do
      enable :login, :logout
    end
    roda(:personal_access_tokens) do |r|
      rodauth.require_authentication
      '1'
    end

    res = json_request("/", :headers=>{'HTTP_AUTHORIZATION'=>'Basic foo'})
    res.must_equal [401, {"reason"=>"login_required", 'error'=>'Please login to continue'}]

  end
end
