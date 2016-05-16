class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:player).permit(:username, :email, :password, :password_confirmation)
  end

end
