require 'rails_helper'

RSpec.describe 'ユーザー新規登録とログイン', type: :system do
  before do
    @user_a = FactoryBot.build(:user)
    @user = FactoryBot.create(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー新規登録ができるとき' do 
      it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
        # トップページに移動する
        visit root_path
        # トップページにサインアップページへ遷移するボタンがあることを確認する
        expect(page).to have_content('新規登録')
        # 新規登録ページへ移動する
        visit new_user_registration_path
        # ユーザー情報を入力する
        fill_in 'Name', with: @user_a.name
        fill_in 'Email', with: @user_a.email
        fill_in 'Password', with: @user_a.password
        # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(1)
        # トップページへ遷移したことを確認する
        expect(current_path).to eq root_path
        # カーソルを合わせるとログアウトボタンが表示されることを確認する
        expect(
          find(".user_nav").find("span").hover
        ).to have_content('ログアウト')
        # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
        expect(page).to have_no_content('新規登録')
        expect(page).to have_no_content('ログイン')
      end
    end

    context 'ユーザー新規登録ができないとき' do
      it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
        # トップページに移動する
        visit root_path
        # トップページにサインアップページへ遷移するボタンがあることを確認する
        expect(page).to have_content('新規登録')
        # 新規登録ページへ移動する
        visit new_user_registration_path
        # ユーザー情報を入力する
        fill_in 'Name', with: ""
        fill_in 'Email', with: ""
        fill_in 'Password', with: ""
        # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(0)
        # 新規登録ページへ戻されることを確認する
        expect(current_path).to eq "/users"
      end
    end
  end

  describe 'ログイン' do
    context 'ログインができるとき' do 
      it '正しい情報を入力すればログインができてトップページに移動する' do
        # ログインする
        sign_in(@user)
        # カーソルを合わせるとログアウトボタンが表示されることを確認する
        expect(
          find(".user_nav").find("span").hover
        ).to have_content('ログアウト')
        # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
        expect(page).to have_no_content('新規登録')
        expect(page).to have_no_content('ログイン')
      end
    end

    context 'ログインができないとき' do
      it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認する
        expect(page).to have_content('ログイン')
        # ログインページへ移動する
        visit new_user_session_path
        # ユーザー情報を入力する
        fill_in 'Email', with: ""
        fill_in 'Password', with: ""
        # ログインボタンを押してもログインページへ戻されることを確認する
        find('input[name="commit"]').click
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end