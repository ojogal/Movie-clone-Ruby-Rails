require 'rails_helper'

RSpec.describe "Movies", type: :request do
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

  describe "GET /index" do
    it "assigns @movies" do
      get '/movies'
      expect(assigns(:movies)).to eq([movie])
    end

    it "renders the index template" do
      get '/movies'
      expect(response).to render_template("index")
    end

    it "has an HTTP status" do
      get '/movies'
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /show" do
    it "renders the show template" do
      get '/movies/1'
      expect(response).to render_template("show")
    end

    it "has an HTTP status" do
      get '/movies/1'
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /new" do
    it "does not render the new template without sign in" do
      get '/movies/new'
      expect(response).to redirect_to("/users/sign_in")
    end

    it "has an HTTP status without sign in" do
      get '/movies/new'
      expect(response).to have_http_status(:found)
    end

    it "renders the new template when sign in" do
      login_as(user, scope: :user)
      get '/movies/new'
      expect(response).to render_template(:new)
    end

    it "has an HTTP status when sign in" do
      login_as(user, scope: :user)
      get '/movies/new'
      expect(response).to have_http_status(:ok)
    end
  end
  
  describe 'GET /edit ' do 
    it 'rendera edit' do
      login_as(user, scope: :user)
      get '/movies/1/edit'
      expect(response).to render_template(:edit)
    end
  end
    
  describe "POST movies#create" do
    it "should create a new movie" do
      login_as(user, scope: :user)
      post '/movies', params: {
        movie: {
          title: "AnythingOnce", 
          text: "AnythingOnce", 
          category: "AnythingOnce",
        }
      }
      expect(response).to redirect_to(assigns(:movie))
    end
  end

  describe "PATCH /update" do
    it "should update a movie" do
      login_as(user, scope: :user)
      patch '/movies/1', params: {
        movie: {
          title: "AnythingTwice", 
          text: "AnythingTwice", 
          category: "AnythingTwice",
        }
      }
      expect(response).to redirect_to(assigns(:movie))
    end
  end

  describe "DELETE movie" do
    before(:each) do
      login_as(user, scope: :user)
      delete "/movies/1"
    end

    it 'should return status 200' do
      expect(response).to redirect_to("/movies")
    end
  end
end
 