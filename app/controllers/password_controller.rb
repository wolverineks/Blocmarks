class PasswordController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.send_password_reset
      redirect_to root_url, notice: 'Email sent with instructions.'
    else
      redirect_to root_url, notice: 'User not found.'
    end
  end

  def edit
    @user = User.find_by!(reset_token: params[:id])
  end

  def update
    @user = User.find_by!(reset_token: params[:id])
    if @user.password_reset_sent_at > 2.hours.ago
      redirect_to new_password_path, alert: 'Password reset has expired.'
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, notice: 'Password has been updated'
    else
      render :edit
    end
  end
end
