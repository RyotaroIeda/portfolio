class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @sauna = Comment.find_by(id: params[:sauna_id])
    @comment = Comment.new(comment_params)
    @comment.save
    if @comment.save
      redirect_back fallback_location: root_path
      flash[:notice] = "口コミを投稿しました"
    else
      redirect_back fallback_location: root_path
      flash[:alert] = "投稿に失敗しました"
    end
  end

  def destroy
    @sauna = Comment.find_by(id: params[:sauna_id])
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_back fallback_location: root_path
      flash[:notice] = "口コミを削除しました"
    else
      redirect_back fallback_location: root_path
      flash[:alert] = "削除に失敗しました"
    end
  end

  private

  def comment_params
    params.required(:comment).permit(:content).merge(user_id: current_user.id, sauna_id: params[:sauna_id])
  end
end
