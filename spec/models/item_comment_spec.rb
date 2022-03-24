# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemComment, type: :model do
  before do
   @end_user = FactoryBot.build(:end_user)
   @Item_comment = FactoryBot.build(:item_comment)
  end
  it '有効な投稿内容の場合保存される' do
    expect(FactoryBot.build(:item_comment)).to be_valid
  end
  it '空白の場合バリデーションで送信されない' do
    item = @end_user.items.build(name:'hoge', body:'hoge')
    item_comment = item.item_comments.build(comment: '')
    expect(item_comment).to be_invalid
  end
end