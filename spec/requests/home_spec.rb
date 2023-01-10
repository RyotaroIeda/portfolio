require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "home#top" do
    let(:user) { create(:user) }
    let(:user2) { create(:user, name: "ゲストユーザー") }
    let!(:sauna) { create(:sauna, user_id: user.id) }
    let!(:favorite) { create(:favorite, user_id: user.id, sauna_id: sauna.id) } # 人気ランキングの検証用

    context "ログインしていない場合" do
      before do
        get root_path
      end

      it "topページへアクセスできること" do
        expect(response).to have_http_status(:success)
      end

      it "新規登録機能が含まれること" do
        expect(response.body).to include("新規登録")
      end

      it "ログイン機能が含まれること" do
        expect(response.body).to include("ログイン")
        expect(response.body).to include("ゲストログイン")
      end

      it "ログイン画面の表示に成功すること" do
        get new_user_session_path
        expect(response).to have_http_status(:success)
      end

      it "新規登録画面の表示に成功すること" do
        get new_user_registration_path
        expect(response).to have_http_status(:success)
      end

      it "人気サウナランキングが含まれること" do
        expect(response.body).to include("人気サウナランキング")
      end

      it "お気に入り数に応じてランキングが表示されること" do
        expect(response.body).to include("第1位")
        expect(response.body).to include(sauna.name)
        expect(response.body).to include("詳細を見る")
        expect(response.body).to include("card-img-top")
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
        get root_path
      end

      it "topページへアクセスできること" do
        expect(response).to have_http_status(:success)
      end

      it "新規登録機能が含まれないこと" do
        expect(response.body).not_to include("新規登録")
      end

      it "ログイン機能が含まれないこと" do
        expect(response.body).not_to include("ログイン")
        expect(response.body).not_to include("ゲストログイン")
      end

      it "ヘッダーにメニューバーが含まれること" do
        expect(response.body).to include("About")
        expect(response.body).to include(user.name)
        expect(response.body).to include("プロフィール編集")
        expect(response.body).to include("新規サウナ登録")
        expect(response.body).to include("サウナ一覧")
        expect(response.body).to include("お気に入りサウナ")
        expect(response.body).to include("ログアウト")
      end

      it "人気サウナランキングが含まれること" do
        expect(response.body).to include("人気サウナランキング")
      end

      it "お気に入り数に応じてランキングが表示されること" do
        expect(response.body).to include("第1位")
        expect(response.body).to include(sauna.name)
        expect(response.body).to include("詳細を見る")
        expect(response.body).to include("card-img-top")
      end
    end

    context "ゲストユーザーとしてログインしている場合" do
      before do
        sign_in user2
        get root_path
      end

      it "topページへアクセスできること" do
        expect(response).to have_http_status(:success)
      end

      it "新規登録機能が含まれないこと" do
        expect(response.body).not_to include("新規登録")
      end

      it "ログイン機能が含まれないこと" do
        expect(response.body).not_to include("ログイン")
        expect(response.body).not_to include("ゲストログイン")
      end

      it "ゲストユーザーでログインした場合、メニューバーにプロフィール編集が表示されないこと" do
        expect(response.body).to include("About")
        expect(response.body).to include(user2.name)
        expect(response.body).not_to include("プロフィール編集")
        expect(response.body).to include("新規サウナ登録")
        expect(response.body).to include("サウナ一覧")
        expect(response.body).to include("お気に入りサウナ")
        expect(response.body).to include("ログアウト")
      end

      it "人気サウナランキングが含まれること" do
        expect(response.body).to include("人気サウナランキング")
      end

      it "お気に入り数に応じてランキングが表示されること" do
        expect(response.body).to include("第1位")
        expect(response.body).to include(sauna.name)
        expect(response.body).to include("詳細を見る")
        expect(response.body).to include("card-img-top")
      end
    end
  end

  describe "home#about" do
    before do
      get about_path
    end

    it "aboutページへアクセスできること" do
      expect(response).to have_http_status(:success)
    end

    it "新規登録機能が含まれること" do
      expect(response.body).to include("新規登録")
    end

    it "ログイン機能が含まれること" do
      expect(response.body).to include("ログイン")
    end
  end

  describe "home#terms" do
    before do
      get terms_path
    end

    it "利用規約ページへアクセスできること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "home#policy" do
    before do
      get policy_path
    end

    it "プライバシーポリシーページへアクセスできること" do
      expect(response).to have_http_status(:success)
    end
  end
end
