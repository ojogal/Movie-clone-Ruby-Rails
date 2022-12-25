require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let!(:user) { User.create(id: 1,
                            email: "anything@email.com", 
                            password: 'password123',
                            password_confirmation: 'password123',
                            created_at: Time.now, 
                            updated_at: Time.now + 1.hour, 
                            role: "admin") }

  let!(:movie) { Movie.create(id: 1, 
                              title: "Anything", 
                              text: "Anything", 
                              category: "Anything", 
                              created_at: Time.now, 
                              updated_at: Time.now + 1.hour, 
                              user_id: 1, 
                              image_file_name: "Anything", 
                              image_file_size: 440854, 
                              image_content_type: "image/jpeg", 
                              image_updated_at: Time.now) }


  describe "GET /new" do
    it "does not render the new template without sign in" do
      get '/movies/1/reviews/new'
      expect(response).to redirect_to("/users/sign_in")
    end

    it "has an HTTP status without sign in" do
      get '/movies/1/reviews/new'
      expect(response).to have_http_status(:found)
    end

    it "renders the new template when sign in" do
      login_as(user, scope: :user)
      get '/movies/1/reviews/new'
      expect(response).to render_template(:new)
    end

    it "has an HTTP status when sign in" do
      login_as(user, scope: :user)
      get '/movies/1/reviews/new'
      expect(response).to have_http_status(:ok)
    end
  end

end
