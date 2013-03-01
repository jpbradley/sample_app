require 'spec_helper'

describe "User pages" do
	subject { page }

	before { visit signup_path }

	describe "signup page" do	

		it { should have_selector('h1', text:  'Sign up') }

		it { should have_selector('title', text: full_title('Sign up')) }

	end

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_selector('h1',    text: user.name) }
		it { should have_selector('title', text: user.name) }
	end

	describe "signup" do
		before { visit signup_path }
		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end

			describe "after submission" do
				before { click_button submit }

				it { should have_selector('title', text: 'Sign up') }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.build(:user) }

			before { valid_signup(user) }

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }

				it { should have_selector('title', text: user.name) }
				it { should have_selector('div.alert.alert-success', text: 'Welcome! Your account has been created!') }
				it { should have_link('Sign out') }
			end
		end
	end
end
