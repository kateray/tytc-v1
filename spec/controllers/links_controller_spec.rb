require 'spec_helper'

describe LinksController do

  context 'create link should work' do
    user = FactoryGirl.create(:user)
    # login_as(user, :scope => :user)

    # user = FactoryGirl.create(:user)
    # before do
    #   login_as user
    # end
    # visit '/'

    it {should have_link 'logout'}
  end

end
