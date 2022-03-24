require 'rails_helper'

describe EndUser do
  describe '#create' do
    # 入力されている場合のテスト ▼
    it "全ての項目の入力が存在すれば登録できること" do
        end_user = build(:end_user)
        expect(end_user).to be_valid
      end
  end
end