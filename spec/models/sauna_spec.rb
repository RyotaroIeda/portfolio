require 'rails_helper'

RSpec.describe Sauna, type: :model do
  describe "バリデーションのテスト" do
    subject { test_sauna.valid? }

    let(:user) { create(:user) }
    let(:test_sauna) { sauna }
    let!(:sauna) { build(:sauna, user_id: user.id) }

    context "presenceのチェック" do
      it "nameカラムが空欄の場合エラーになること" do
        test_sauna.name = ""
        is_expected.to eq false
      end

      it "privacyカラムにチェックを入れていないとエラーになること" do
        test_sauna.privacy = ""
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "userモデルとの関係" do
      it "N対1となっている" do
        expect(Sauna.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
