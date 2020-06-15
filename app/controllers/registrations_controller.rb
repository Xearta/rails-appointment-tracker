class RegistrationsController < Devise::RegistrationsController
    private
	def signup_params
        params.require(:user).permit(:username, :email, :password,  :password_confirmation)
	end
	
	def account_update_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation)
	end
end
