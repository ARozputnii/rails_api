class Api::V1::SessionsController < Devise::SessionsController
  before_action :sign_in_params, only: :create
  before_action :set_user, only: :create
  before_action :valid_token, only: :destroy
  skip_before_action :verify_signed_out_user, only: :destroy

  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in "user", @user
      json_response("Signed In Successfully", true, {user: @user}, :ok)
    else
      json_response("Unauthorized", false, {}, :unauthorized)
    end
  end

  def destroy
    sign_out @user
    @user.generate_new_authentication_token
    json_response("Log out seccessfully", true, {}, :ok)
  end

  private
  def sign_in_params
    params.require(:sign_in).permit(:email, :password)
  end

  def set_user
    @user = User.find_for_database_authentication(email: sign_in_params[:email])
    if @user
      @user
    else
      json_response("Cannot find user", false, {}, :unprocessable_entity)
    end
  end

  def valid_token
    @user = User.find_by(authentication_token: request.headers["AUTH-TOKEN"])
    if @user
      @user
    else
      json_response("Invalod Token", false, {}, :unprocessable_entity)
    end
  end
end