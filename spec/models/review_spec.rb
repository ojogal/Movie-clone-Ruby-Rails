require 'rails_helper'

RSpec.describe Review, type: :model do
  let!(:user) { User.create(id: 1,
                            email: "anything@email.com", 
                            password: 'password123',
                            password_confirmation: 'password123',
                            created_at: Time.now, 
                            updated_at: Time.now + 1.hour, 
                            role: "basic") }

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

  subject { described_class.new(id: 1, 
                                rating: 5, 
                                user_id: 1, 
                                movie_id: 1, 
                                created_at: Time.now, 
                                updated_at: Time.now + 1.hour) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  context "Model is not valid when" do
    it "has a rating not from 1-5" do
      subject.rating = 6
      expect(subject).to_not be_valid
    end

    it "has a rating as not Integer" do
      subject.rating = 'string'
      expect(subject).to_not be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'associations' do
    it { should belong_to(:movie) }
  end
end
