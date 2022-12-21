class FavoritesController < ApplicationController
  before_action :set_sauna

	#お気に入り追加
  def create
    @favorite = Favorite.create(user_id: current_user.id, sauna_id: @sauna.id)
  end

  #お気に入り解除
  def destroy
		@favorite = Favorite.find_by(user_id: current_user.id, sauna_id: @sauna.id)
    @favorite.destroy
    redirect_to sauna_path(@sauna) #お気に入りを解除するがリロードしないと★表示が変わらなかったため一旦これで
  end

  private
  def set_sauna
    @sauna = Sauna.find(params[:sauna_id])
  end
end
