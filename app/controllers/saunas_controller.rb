class SaunasController < ApplicationController
  before_action :set_q, only: [:index, :search]
  before_action :authenticate_user!, except: [:index, :show, :search]

  def index
    if params[:latest]
      @saunas = Sauna.latest.page(params[:page]).per(15).includes(:user)
    elsif params[:old]
      @saunas = Sauna.old.page(params[:page]).per(15).includes(:user)
    elsif params[:name]
      @saunas = Sauna.name_order.page(params[:page]).per(15).includes(:user)
    else
      @saunas = Sauna.all.page(params[:page]).per(15).includes(:user)
    end
  end

  def show
    @sauna = Sauna.find_by(id: params[:id])
    @comment = Comment.new
    @comments = @sauna.comments.includes(:user)
    if (@sauna.privacy == "2") && (@sauna.user_id != current_user)
      redirect_back fallback_location: saunas_path
      flash[:alert] = "非公開に設定されているサウナのため閲覧できません"
    end
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
    if @sauna.user != current_user
      redirect_to sauna_path(@sauna)
      flash[:alert] = "不正なアクセスです"
    end
    if (@sauna.privacy == "2") && (@sauna.user_id != current_user.id)
      redirect_back fallback_location: saunas_path
      flash[:alert] = "非公開に設定されているサウナのため編集できません"
    end
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

  def destroy
    @sauna = Sauna.find_by(id: params[:id])
    @sauna.destroy
    redirect_to saunas_path
    flash[:notice] = "#{@sauna.name}を削除しました"
  end

  def search
    @saunas = Sauna.all.page(params[:page]).per(15)
  end

  private

  def set_q
    @q = Sauna.ransack(params[:q])
  end

  def sauna_params
    params.require(:sauna).permit(:name, :image, :water_temperature, :open_time, :close_time,
    :sauna_temperature, :sauna_capacity, :water_capacity, :sauna_body, :water_body, :louly_aufgoose,
    :louly_body, :rest_space, :rest_body, :address, :access, :tel, :price, :http, :latitude, :longitude, :privacy)
  end
end
