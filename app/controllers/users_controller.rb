require 'pry'

class UsersController < ApplicationController
  include ApplicationHelper

  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to new_user_path, alert: "Invalid inputs"
    end
  end

  def show
    if !current_user || current_user.id != params[:id].to_i
      redirect_to root_path
    end

    @user = User.find_by(id: params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :happiness, :nausea, :height, :tickets, :admin)
  end
end
