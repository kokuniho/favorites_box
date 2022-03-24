# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
    before  do
      @end_user = build(:end_user)
    end
    it '有効な投稿内容の場合は保存されるか' do
      item = @end_user.items.build(name:'hoge', body:'hoge')
      expect(item).to be_valid
    end
  context "空白のバリデーションチェック" do
    it "name##3が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってくるか" do
    item = @end_user.items.build(name:'', body:'hoge')
    expect(item).to be_invalid
    expect(item.errors[:name]).to include("can't be blank")
    end
    it "bodyが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってくるか" do
    item = @end_user.items.build(name:'hoge', body:'')
    expect(item).to be_invalid
    expect(item.errors[:body]).to include("can't be blank")
    end
  end
end