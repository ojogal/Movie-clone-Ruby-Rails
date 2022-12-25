require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { User.create(id: 1,
                            email: "anything@email.com", 
                            password: 'password123',
                            password_confirmation: 'password123',
                            created_at: Time.now, 
                            updated_at: Time.now + 1.hour, 
                            role: "admin") }

  let!(:user_basic) { User.create(id: 2,
                                  email: "anythingbasic@email.com", 
                                  password: 'password123',
                                  password_confirmation: 'password123',
                                  created_at: Time.now, 
                                  updated_at: Time.now + 1.hour, 
                                  role: "basic") }

  describe 'the signin process', type: :feature do
    it 'signs @user in' do
      visit '/users/sign_in'
      fill_in 'Email', with: 'anything@email.com'
      fill_in 'Password', with: 'password123'
      click_button 'Log in'
     expect(current_path).to eq(root_path)
     expect(page).to have_text('Signed in successfully.')
    end
  end

  describe "GET /index" do
    it "renders the index template" do
      login_as(user, scope: :user)
      get '/admin/users'
      expect(response).to render_template("index")
    end

    it "has an HTTP status" do
      login_as(user, scope: :user)
      get '/admin/users'
      expect(response).to have_http_status(:ok)
    end

    it "does not render the index template without sign in" do
      get '/admin/users'
      expect(response).to redirect_to("/users/sign_in")
    end

    it "has an HTTP status without sign in" do
      get '/admin/users'
      expect(response).to have_http_status(:found)
    end
  end

  describe 'GET /edit ' do 
    it 'rendera edit' do
      login_as(user, scope: :user)
      get '/admin/users/1/edit'
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH /update" do
    it "should update a new movie" do
      login_as(user, scope: :user)
      patch '/admin/users/2', params: {
        user: {
          role: "admin", 
        }
      }
      expect(response).to redirect_to("/admin/users")
    end
  end

  describe "DELETE user" do
    before(:each) do
      login_as(user, scope: :user)
      delete "/admin/users/2"
    end

    it 'should return status 200' do
      expect(response).to redirect_to("/admin/users")
    end
  end
end
