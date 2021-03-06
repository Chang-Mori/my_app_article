require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメントの保存' do
    context "コメントが投稿できる場合" do
      it "テキストがあれば投稿できる" do
        expect(@comment).to be_valid
      end
    end

    context "コメントが投稿できない場合" do
      it 'テキストが空の場合コメントは保存できない' do
        @comment.text = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end

      it 'ユーザーが紐付いていないとコメントは保存できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("User must exist")
      end

      it '記事が紐付いていないとコメントは保存できない' do
        @comment.article = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Article must exist")
      end
    end
  end
end