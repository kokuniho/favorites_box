# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @end_user = build(:end_user)
  end
  it '有効な投稿内容の場合は保存されるか' do
    expect(FactoryBot.build(:message)).to be_valid
  end
  it "messageが空白の場合にバリデーションチェックされ、送信できないか" do
      message = Message.new(message: '')
      expect(message).to be_invalid
  end
end
