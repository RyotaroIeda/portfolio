class HomeController < ApplicationController
  def top
    @sauna_favorite_ranks = Sauna.find(Favorite.group(:sauna_id).limit(3).order('count(sauna_id) desc').pluck(:sauna_id))
  end

  def about
  end

  def terms
  end

  def policy
  end
end
