require 'rails_helper'

RSpec.describe "Saunas", type: :request do
  let(:user) { create(:user) }
  let!(:sauna) { create(:sauna, user_id: user.id) }
  let!(:comment) { create(:comment, user_id: user.id, sauna_id: sauna.id) }
  let!(:favorite) { create(:favorite, user_id: user.id, sauna_id: sauna.id) }
  let!(:sauna2) { create(:sauna, name: "非公開サウナ", privacy: "2", user_id: user.id) } # 公開非公開の検証用
  let!(:sauna3) { create(:sauna, name: "かるまる", user_id: user.id) } # 更新用

  describe "GET# /show" do
    context "サウナが公開状態になっている場合" do
      before do
        get sauna_path(sauna.id)
      end

      it "showページが表示できること" do
        expect(response).to have_http_status(:success)
      end

      it "サウナ情報が含まれること" do
        expect(response.body).to include(sauna.name)
        expect(response.body).to include(sauna.water_temperature.to_s)
        expect(response.body).to include(sauna.open_time.strftime("%H:%M"))
        expect(response.body).to include(sauna.close_time.strftime("%H:%M"))
        expect(response.body).to include(sauna.sauna_temperature.to_s)
        expect(response.body).to include(sauna.sauna_capacity.to_s)
        expect(response.body).to include(sauna.water_capacity.to_s)
        expect(response.body).to include(sauna.sauna_body)
        expect(response.body).to include(sauna.water_body)
        expect(response.body).to include(sauna.louly_body)
        expect(response.body).to include(sauna.rest_body)
        expect(response.body).to include(sauna.address)
        expect(response.body).to include(sauna.access)
        expect(response.body).to include(sauna.tel)
        expect(response.body).to include(sauna.price)
        expect(response.body).to include(sauna.http)
      end

      it "コメント一覧にコメントが表示されていること" do
        expect(response.body).to include(comment.content)
      end
    end

    context "サウナが非公開状態になっている場合" do
      before do
        get sauna_path(sauna2.id)
      end

      it "indexページへリダイレクトされること" do
        expect(response).to redirect_to saunas_path
      end
    end
  end

  describe "GET# /edit" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクトすること" do
        get edit_sauna_path(sauna.id)
        expect(response).to redirect_to user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
        get edit_sauna_path(sauna.id)
      end

      it "ログイン中、editページが表示できること" do
        expect(response).to have_http_status(:success)
      end

      it "サウナ情報が含まれること" do
        expect(response.body).to include(sauna.name)
        expect(response.body).to include(sauna.water_temperature.to_s)
        expect(response.body).to include(sauna.sauna_temperature.to_s)
        expect(response.body).to include(sauna.sauna_capacity.to_s)
        expect(response.body).to include(sauna.water_capacity.to_s)
        expect(response.body).to include(sauna.sauna_body)
        expect(response.body).to include(sauna.water_body)
        expect(response.body).to include(sauna.louly_body)
        expect(response.body).to include(sauna.rest_body)
        expect(response.body).to include(sauna.address)
        expect(response.body).to include(sauna.access)
        expect(response.body).to include(sauna.tel)
        expect(response.body).to include(sauna.price)
        expect(response.body).to include(sauna.http)
      end
    end
  end

  describe "GET# /index" do
    before do
      get saunas_path
    end

    it "indexページが表示できること" do
      expect(response).to have_http_status(:success)
    end

    it "ソート機能が含まれていること" do
      expect(response.body).to include("並び順")
      expect(response.body).to include("新しい順")
      expect(response.body).to include("古い順")
      expect(response.body).to include("名前順")
    end

    it "サウナ一覧が表示されていること" do
      expect(response.body).to include("サウナ一覧")
    end

    context "サウナが公開状態の場合" do
      it "サウナ情報が含まれること" do
        expect(response.body).to include(sauna.name)
        expect(response.body).to include("card-img-top")
        expect(response.body).to include("詳細を見る")
      end
    end

    context "サウナが非公開状態の場合" do
      it "別のユーザーからはサウナ名が含まれないこと" do
        sign_in user
        expect(response.body).not_to include(sauna2.name)
      end
    end
  end

  describe "GET# /new" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクトすること" do
        get new_sauna_path
        expect(response).to redirect_to user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
        get new_sauna_path
      end

      it "ログイン中、newページが表示できること" do
        expect(response).to have_http_status(:success)
      end

      it "サウナ情報が含まれること" do
        expect(response.body).to include("新規サウナ登録画面")
        expect(response.body).to include("公開・非公開(必須)")
        expect(response.body).to include("サウナ名(必須)")
        expect(response.body).to include("サウナ画像")
        expect(response.body).to include("住所")
        expect(response.body).to include("ホームページ")
        expect(response.body).to include("料金")
        expect(response.body).to include("アクセス")
        expect(response.body).to include("電話番号")
        expect(response.body).to include("開店時間")
        expect(response.body).to include("閉店時間")
        expect(response.body).to include("サウナの温度(℃)")
        expect(response.body).to include("水風呂の温度(℃)")
        expect(response.body).to include("サウナの収容人数(人)")
        expect(response.body).to include("水風呂の収容人数(人)")
        expect(response.body).to include("サウナ詳細")
        expect(response.body).to include("水風呂詳細")
        expect(response.body).to include("ロウリュ・アウフグースサービスの有無")
        expect(response.body).to include("ロウリュ・アウフグースサービス詳細")
        expect(response.body).to include("休憩スペースの有無")
        expect(response.body).to include("休憩スペース詳細")
        expect(response.body).to include("サウナを登録する")
      end
    end
  end

  describe "POST# /create" do
    before do
      sign_in user
    end

    context "パラメータが正常な場合" do
      it "リクエストが成功すること" do
        post saunas_path, params: { sauna: FactoryBot.attributes_for(:sauna) }
        expect(response.status).to eq 302
      end

      it "サウナが登録されること" do
        expect do
          post saunas_path, params: { sauna: FactoryBot.attributes_for(:sauna) }
        end.to change(Sauna, :count).by(1)
      end

      it "リダイレクトすること" do
        post saunas_path, params: { sauna: FactoryBot.attributes_for(:sauna) }
        expect(response).to redirect_to Sauna.last
      end
    end

    context "パラメータが不正な場合" do
      it "リクエストが成功すること" do
        post saunas_path, params: { sauna: FactoryBot.attributes_for(:sauna, :invalid) }
        expect(response.status).to eq 200
      end

      it "サウナが登録されないこと" do
        expect do
          post saunas_path, params: { sauna: FactoryBot.attributes_for(:sauna, :invalid) }
        end.not_to change(Sauna, :count)
      end

      it "エラーが表示されること" do
        post saunas_path, params: { sauna: FactoryBot.attributes_for(:sauna, :invalid) }
        expect(response.body).to include "サウナ名を入力してください"
        expect(response.body).to include "公開・非公開を入力してください"
      end
    end
  end

  describe "PUT# /update" do
    before do
      sign_in user
    end

    context "パラメータが妥当な場合" do
      it "リクエストが成功すること" do
        put sauna_path(sauna3.id), params: { sauna: FactoryBot.attributes_for(:sauna) }
        expect(response.status).to eq 302
      end

      it "サウナ名が更新されること" do
        expect do
          put sauna_path(sauna3.id), params: { sauna: FactoryBot.attributes_for(:sauna) }
        end.to change { Sauna.find(sauna3.id).name }.from("かるまる").to("MyString")
      end

      it "リダイレクトすること" do
        put sauna_path(sauna3.id), params: { sauna: FactoryBot.attributes_for(:sauna) }
        expect(response).to redirect_to sauna_path(sauna3.id)
      end
    end

    context "パラメータが不正な場合" do
      it "リクエストが成功すること" do
        put sauna_path(sauna3.id), params: { sauna: FactoryBot.attributes_for(:sauna, :invalid) }
        expect(response.status).to eq 200
      end

      it "サウナ名が変更されないこと" do
        expect do
          put sauna_path(sauna3.id), params: { sauna: FactoryBot.attributes_for(:sauna, :invalid) }
        end.not_to change(Sauna.find(sauna.id), :name)
      end

      it 'エラーが表示されること' do
        put sauna_path(sauna3.id), params: { sauna: FactoryBot.attributes_for(:sauna, :invalid) }
        expect(response.body).to include "サウナ名を入力してください"
        expect(response.body).to include "公開・非公開を入力してください"
      end
    end
  end

  describe "DELETE# /destroy" do
    before do
      sign_in user
    end

    it "リクエストが成功すること" do
      delete sauna_path(sauna.id)
      expect(response.status).to eq 302
    end

    it "ユーザーが削除されること" do
      expect do
        delete sauna_path(sauna.id)
      end.to change(Sauna, :count).by(-1)
    end

    it "ユーザー一覧にリダイレクトすること" do
      delete sauna_path(sauna.id)
      expect(response).to redirect_to saunas_path
    end
  end

  describe "検索のテスト" do
    it "正しいパラメータが渡されている場合" do
      @params = {}
      @params[:q] = { name_cont: "test" }
      @q = Sauna.ransack(@params)
      @search = @q.result
      expect(@search) == ({ name: "test" })
    end

    it "不正なパラメータが渡されている場合" do
      @params = {}
      @params[:q] = { name_cont: "test" }
      @q = Sauna.ransack(@params)
      @search = @q.result
      expect(@search) != ({ name: "test2" })
    end
  end
end
