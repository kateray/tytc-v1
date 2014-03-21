require 'spec_helper'

describe UsersController do

  describe 'log in' do
    before { visit new_user_session_path }
      subject { page }

    describe 'should be able to log in with correct password' do
      before do
        user = FactoryGirl.create(:user)
        fill_in 'user_login', with: user.username
        fill_in 'user_password', with: user.password
        click_on 'Sign in'
      end
      it {should have_link 'logout'}
    end


    describe 'should show errors if wrong password' do
      before do
        user = FactoryGirl.create(:user)
        fill_in 'user_login', with: user.username
        fill_in 'user_password', with: 'verybadpassword'
        click_on 'Sign in'
      end
      it {should have_content "Invalid username or password." }
    end

  end


  describe 'sign up' do
    before {visit new_user_registration_path}
    subject {page}

    describe 'should allow sign up' do
      before do
        fill_in 'user_username', with: 'testkray'
        fill_in 'user_password', with: 'testpassword'
        fill_in 'user_password_confirmation', with: 'testpassword'
        click_on 'Sign up'
      end
      it {should have_link 'logout'}
    end

  end

  # context "signed in as non-admin user" do
  #   let(:user) {create(:user, :god => false)}
  #   before do
  #     sign_in_as user
  #     get :index
  #   end
  # 
  #   it { should respond_with(:success)}
  # end

  # github login

end
