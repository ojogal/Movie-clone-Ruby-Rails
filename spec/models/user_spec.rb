require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(id: 1,
                                email: "anything@email.com", 
                                password: 'password123',
                                password_confirmation: 'password123',
                                created_at: Time.now, 
                                updated_at: Time.now + 1.hour, 
                                role: "basic") }

  it 'is database authenticable' do
    expect(subject.valid_password?('password123')).to be_truthy
  end

  context "validations" do
    context "presence" do
      it { should validate_presence_of :email }
      it { should validate_presence_of :password }
    end

    context "uniqueness" do
      it { should validate_uniqueness_of(:email).case_insensitive }
    end
  end
end