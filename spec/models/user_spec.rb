require 'rails_helper'

RSpec.describe User, type: :model do
	let(:name)			{ 'Foo Bar' }
	let(:proper_email)	{ 'foobar@gmail.com' }
	let(:improper_email){ 'foobar' }
	let(:password)		{ 'foobar1234' }


	context "validation: " do
		it { is_expected.to validate_presence_of(:name) }
		it { is_expected.to allow_value(:proper_email).for(:email) }
		it { is_expected.not_to allow_value(:improper_email).for(:email)  }
		it { is_expected.to validate_uniqueness_of(:email) }
		it { is_expected.to validate_presence_of(:password) }
	end

	context "creates: " do
		it "takes in valid parameters" do
			expect{ User.create(name: name, email: proper_email, password: password) }.not_to raise_error
		end

		it "creates a new user when passed in valid parameters" do
			User.create(name: name, email: proper_email, password: password)
			expect( User.find_by(email: proper_email) ).not_to be nil
		end
	end
end
