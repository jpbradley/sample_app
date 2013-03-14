include ApplicationHelper

def valid_signin(user)
	visit signin_path
	fill_in "Email", 	with: user.email
	fill_in "Password", with: user.password
	click_button "Sign in"

	cookies[:remember_token] = user.remember_token
end

def valid_signup(user)
	fill_in "Name", 		with: user.name
	fill_in "Email", 		with: user.email
	fill_in "Password", 	with: user.password
	fill_in "Confirmation", with: user.password_confirmation
end

RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		page.should have_selector('div.alert.alert-error', text: message)
	end
end

RSpec::Matchers.define :have_h1_selector do |h1|
	match do |page|
		page.should have_selector('h1', text: h1)
	end
end

RSpec::Matchers.define :have_title_selector do |title|
	match do |page|
		page.should have_selector('title', text: title)
	end
end
