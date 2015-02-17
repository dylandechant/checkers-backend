class RegistrationsController < Devise::RegistrationsController
  def create 
    @user = User.new(params[:id])
    if @user.save
      render json: { :user => @user }, status: :created
    else
      render json: { :messages => @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private 
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
