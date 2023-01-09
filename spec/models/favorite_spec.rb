require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "バリデーションのテスト" do
    subject { favorite.valid? }

    let!(:other_favorite) { create(:favorite) }
    let(:favorite) { build(:favorite) }

    it "あるUserが同じサウナにいいね出来ないこと" do
      favorite.user = other_favorite.user
      favorite.sauna = other_favorite.sauna
      is_expected.to eq false
    end
  end

  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N対1となっている" do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context "Saunaモデルとの関係" do
      it "N対1となっている" do
        expect(Favorite.reflect_on_association(:sauna).macro).to eq :belongs_to
      end
    end
  end
end
