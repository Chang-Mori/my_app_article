require 'rails_helper'

RSpec.describe '記事投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.build(:article)
  end

  context '記事投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_article_path
      # フォームに情報を入力する
      fill_in 'article_title', with: @article.title
      fill_in 'article_text', with: @article.text
      # fill_in 'article_genre_id', with: @article.genre_id
      find("#article_genre_id").find("option[value='2']").select_option
      # 送信するとArticleモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Article.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(current_path).to eq articles_path
      # 「投稿が完了しました」の文字があることを確認する
      expect(page).to have_content('投稿が完了しました。')
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容の記事が存在することを確認する（タイトル）
      expect(page).to have_content(@article.title)
      # トップページには先ほど投稿した内容の記事が存在することを確認する（テキスト）
      expect(page).to have_content(@article.text)
    end
  end

  context '記事投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('投稿する')
    end
  end
end

RSpec.describe '記事編集', type: :system do
  before do
    @article1 = FactoryBot.create(:article)
    @article2 = FactoryBot.create(:article)
  end

  context '記事編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した記事の編集ができる' do
      # 記事1を投稿したユーザーでログインする
      sign_in(@article1.user)
      # 記事に「詳細」ボタンがある
      # expect(
      #   all(".more")[0].hover
      # ).to have_link '詳細', href: article_path(@article1)
      # 詳細ページに遷移する
      visit article_path(@article1)
      # 記事1に「編集」ボタンがあることを確認する
      expect(
        all(".more")[0].hover
      ).to have_link '編集', href: edit_article_path(@article1)
      # 編集ページへ遷移する
      visit edit_article_path(@article1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#article_title').value
      ).to eq @article1.title
      expect(
        find('#article_text').value
      ).to eq @article1.text
      # 投稿内容を編集する
      fill_in 'article_title', with: "#{@article1.title}+編集したタイトル"
      fill_in 'article_text', with: "#{@article1.text}+編集したテキスト"
      # 編集してもArticleモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Article.count }.by(0)
      # 編集完了画面に遷移したことを確認する
      expect(current_path).to eq article_path(@article1)
      # 「更新が完了しました」の文字があることを確認する
      expect(page).to have_content('更新が完了しました。')
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容の記事が存在することを確認する（タイトル）
      expect(page).to have_content("#{@article1.title}+編集したタイトル")
      # トップページには先ほど変更した内容の記事が存在することを確認する（テキスト）
      expect(page).to have_content("#{@article1.text}+編集したテキスト")
    end
  end

  context '記事編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した記事の編集画面には遷移できない' do
      # 記事1を投稿したユーザーでログインする
      sign_in(@article1.user)
      # 記事2に「編集」ボタンがないことを確認する
      expect(
        all(".more")[0].hover
      ).to have_no_link '編集', href: edit_article_path(@article2)
    end
    it 'ログインしていないと記事の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 記事1に「編集」ボタンがないことを確認する
      expect(
        all(".more")[1].hover
      ).to have_no_link '編集', href: edit_article_path(@article1)
      # 記事2に「編集」ボタンがないことを確認する
      expect(
        all(".more")[0].hover
      ).to have_no_link '編集', href: edit_article_path(@article2)
    end
  end
end

RSpec.describe '記事削除', type: :system do
  before do
    @article1 = FactoryBot.create(:article)
    @article2 = FactoryBot.create(:article)
  end

  context '記事削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した記事の削除ができる' do
      # 記事1を投稿したユーザーでログインする
      sign_in(@article1.user)
      # 詳細ページに遷移する
      visit article_path(@article1)
      # 記事1に「削除」ボタンがあることを確認する
      # expect(
      #   all(".more")[1].hover
      # ).to have_link '削除', href: article_path(@article1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        all(".more")[1].hover.find_link('削除', href: article_path(@article1)).click
      }.to change { Article.count }.by(-1)
      # 削除完了画面に遷移したことを確認する
      expect(current_path).to eq article_path(@article1)
      # 「削除が完了しました」の文字があることを確認する
      expect(page).to have_content('削除が完了しました。')
      # トップページに遷移する
      visit root_path
      # トップページには記事1の内容が存在しないことを確認する（タイトル）
      expect(page).to have_no_content("#{@article1.text}")
      # トップページには記事1の内容が存在しないことを確認する（テキスト）
      expect(page).to have_no_content("#{@article1.text}")
    end
  end

  context '記事削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した記事の削除ができない' do
      # 記事1を投稿したユーザーでログインする
      sign_in(@article1.user)
      # 記事2に「削除」ボタンが無いことを確認する
      expect(
        all(".more")[0].hover
      ).to have_no_link '削除', href: article_path(@article2)
    end

    it 'ログインしていないと記事の削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # 記事1に「削除」ボタンが無いことを確認する
      expect(
        all(".more")[1].hover
      ).to have_no_link '削除', href: article_path(@article1)
      # 記事2に「削除」ボタンが無いことを確認する
      expect(
        all(".more")[0].hover
      ).to have_no_link '削除', href: article_path(@article2)
    end
  end
end

RSpec.describe '記事詳細', type: :system do
  before do
    @article = FactoryBot.create(:article)
  end

  it 'ログインしたユーザーは記事詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    sign_in(@article.user)
    # 記事に「詳細」ボタンがある
    expect(
      all(".more")[0].hover
    ).to have_link '詳細', href: article_path(@article)
    # 詳細ページに遷移する
    visit article_path(@article)
    # 詳細ページに記事の内容が含まれている
    expect(page).to have_content("#{@article.title}")
    expect(page).to have_content("#{@article.text}")
    # コメント用のフォームが存在する
    expect(page).to have_selector 'form'
  end

  it 'ログインしていない状態で記事詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    # トップページに移動する
    visit root_path
    # 記事に「詳細」ボタンがある
    expect(
      all(".more")[0].hover
    ).to have_link '詳細', href: article_path(@article)
    # 詳細ページに遷移する
    visit article_path(@article)
    # 詳細ページに記事の内容が含まれている
    expect(page).to have_content("#{@article.title}")
    expect(page).to have_content("#{@article.text}")
    # フォームが存在しないことを確認する
    expect(page).to have_no_selector 'form'
    # 「コメントの投稿には新規登録/ログインが必要です」が表示されていることを確認する
    expect(page).to have_content 'コメントの投稿には新規登録/ログインが必要です'
  end
end