class ApplicationController < ActionController::Base
	protect_from_forgery
	include EmployeeSessionsHelper

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    employee_sign_out
    sign_out
    super
  end
end
