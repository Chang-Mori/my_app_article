require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @article = FactoryBot.build(:article)
  end

  describe '記事の保存' do
    context "記事が投稿できる場合" do
      it "タイトルとテキストとジャンルの選択があれば投稿できる" do
        expect(@article).to be_valid
      end
    end

    context "記事が投稿できない場合" do
      it "テキストが空では投稿できない" do
        @article.title = ""
        @article.valid?
        expect(@article.errors.full_messages).to include("Title can't be blank")
      end
      it "テキストが空では投稿できない" do
        @article.text = ""
        @article.valid?
        expect(@article.errors.full_messages).to include("Text can't be blank")
      end
      it "ジャンルを指定しないと投稿できない" do
        @article.genre_id = 1
        @article.valid?
        expect(@article.errors.full_messages).to include("Genre must be other than 1")
      end
      it "ユーザーが紐付いていなければ投稿できない" do
        @article.user = nil
        @article.valid?
        expect(@article.errors.full_messages).to include("User must exist")
      end
    end
  end
end