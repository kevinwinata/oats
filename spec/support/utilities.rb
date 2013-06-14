def employee_sign_in(employee)
  visit '/employee/signin'
  fill_in "Email",    with: employee.email
  fill_in "Password", with: employee.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = employee.remember_token
end