require 'rails_helper'

RSpec.describe Movie, type: :model do
  let!(:user) { User.create(id: 1,
                            email: "anything@email.com", 
                            password: 'password123',
                            password_confirmation: 'password123',
                            created_at: Time.now, 
                            updated_at: Time.now + 1.hour, 
                            role: "basic") }

  subject { described_class.create(id: 1, 
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


  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  context "Model is not valid when" do
    it "is without a title" do
      subject.title = nil
      expect(subject).to_not be_valid
    end
    it "is without a description" do
      subject.text = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:text) }
  end
end