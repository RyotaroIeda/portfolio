class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "プロフィールを更新しました。"
    redirect_to user_path(@user)
  end

  def favorites
    @user = User.find(params[:id])
    @saunas = @user.saunas
    favorites = @user.favorites.pluck(:sauna_id)
    @favorites = Sauna.find(favorites)
    @favorites = Kaminari.paginate_array(@favorites).page(params[:page]).per(15)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :homesauna, :introduce)
  end
end
