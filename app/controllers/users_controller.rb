class UsersController < ApplicationController
  def recipes
    @user = User.find(params[:user_id])
  end
end
