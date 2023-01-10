require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { comment.valid? }

  let!(:other_comment) { create(:comment) }
  let(:comment) { build(:comment) }

  describe "バリデーションのチェック" do
    context "presenceのチェック" do
      it "contentカラムが空欄の場合エラーになること" do
        comment.content = ""
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N対1となっている" do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context "Saunaモデルとの関係" do
      it "N対1となっている" do
        expect(Comment.reflect_on_association(:sauna).macro).to eq :belongs_to
      end
    end
  end
end
