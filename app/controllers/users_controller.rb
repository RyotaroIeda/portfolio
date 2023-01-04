class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(@user)
      flash[:alert] = "不正なアクセスです"
    end
    if current_user.name = "ゲストユーザー"
      redirect_to user_path(current_user)
      flash[:alert] = "ゲストユーザーは編集できません"
    end
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

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to root_path
    flash[:notice] = "アカウントを削除しました。またのご利用をお待ちしています。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :homesauna, :introduce)
  end
end
