require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    it "引数が渡されている場合に動的な表示がなされること" do
      expect(full_title("sample")).to eq("sample - Sauna&Camp")
    end

    it "引数が空白の場合に動的な表示がなされること" do
      expect(full_title("")).to eq("Sauna&Camp")
    end

    it "引数がnilの場合に動的な表示がなされること" do
      expect(full_title(nil)).to eq("Sauna&Camp")
    end
  end
end
