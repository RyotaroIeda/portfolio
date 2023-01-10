require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) } # userのeditの検証用
  let!(:sauna) { create(:sauna, user_id: user.id) }
  let!(:favorite) { create(:favorite, user_id: user.id, sauna_id: sauna.id) }

  describe "GET# /show" do
    before do
      get user_path(user.id)
    end

    it "showページが表示できること" do
      expect(response).to have_http_status(:success)
    end

    it "ユーザー情報が含まれること" do
      expect(response.body).to include(user.name)
      expect(response.body).to include(user.homesauna)
      expect(response.body).to include(user.introduce)
    end
  end

  describe "GET# /edit" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクトすること" do
        get edit_user_path(user.id)
        expect(response).to redirect_to user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
        get edit_user_path(user.id)
      end

      it "editページが表示できること" do
        expect(response).to have_http_status(:success)
      end

      it "ユーザー情報が含まれること" do
        expect(response.body).to include(user.name)
        expect(response.body).to include(user.homesauna)
        expect(response.body).to include(user.introduce)
      end
    end

    context "ログインはしているが、本人ではない場合" do
      before do
        sign_in user2
        get edit_user_path(user.id)
      end

      it "userのshowページににリダイレクトされる" do
        expect(response).to redirect_to user_path(user.id)
      end
    end
  end

  describe "DELETE# /destroy" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクトすること" do
        delete user_path(user.id)
        expect(response).to redirect_to user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "リクエストが成功すること" do
        delete user_path(user.id)
        expect(response.status).to eq 302
      end

      it "ユーザーが削除されること" do
        expect do
          delete user_path(user.id)
        end.to change(User, :count).by(-1)
      end

      it "トップページにリダイレクトすること" do
        delete user_path(user.id)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET# /favorites" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクトすること" do
        get "/users/#{user.id}/favorites"
        expect(response).to redirect_to user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
        get "/users/#{user.id}/favorites"
      end

      it "お気に入り一覧ページが表示できること" do
        expect(response).to have_http_status(:success)
      end

      it "お気に入りサウナ一覧が表示されること" do
        expect(response.body).to include("お気に入りサウナ一覧")
      end

      it "お気に入りに登録したサウナが表示されること" do
        expect(response.body).to include(sauna.name)
        expect(response.body).to include("詳細を見る")
        expect(response.body).to include("card-img-top")
      end
    end
  end
end
