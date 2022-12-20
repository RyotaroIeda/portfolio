class SaunasController < ApplicationController
  def index
    @saunas = Sauna.all
  end

  def show
    @sauna = Sauna.find_by(id: params[:id])
  end

  def new
    @sauna = Sauna.new
  end

  def create
    @sauna = Sauna.new(sauna_params)
    @sauna.user_id = current_user.id
    if @sauna.save
      redirect_to sauna_path(@sauna)
      flash[:notice] = "#{@sauna.name}を投稿しました"
    else
      render :new
    end
  end

  def edit
    @sauna = Sauna.find_by(id: params[:id])
  end

  def update
    @sauna = Sauna.find_by(id: params[:id])
    if @sauna.update(sauna_params)
      redirect_to sauna_path(@sauna)
      flash[:notice] = "#{@sauna.name}を編集しました"
    else
      render :edit
    end
  end

  private
  def sauna_params
    params.require(:sauna).permit(:name, :image, :water_temperature, :open_time, :close_time, :sauna_temperature, :sauna_capacity, :water_capacity, :sauna_body, :water_body, :louly_aufgoose, :louly_body, :rest_space, :rest_body, :address, :access, :tel, :price)
  end
end