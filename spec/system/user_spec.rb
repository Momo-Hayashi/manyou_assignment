require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do

  let!(:user) {FactoryBot.create(:user) }
  let!(:admin) {FactoryBot.create(:admin) }

  describe 'ユーザ登録' do
    it 'ユーザの新規登録ができる' do
      visit new_user_path
      fill_in 'user_name', with: 'Testing'
      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password', with: 'testing'
      fill_in 'user_password_confirmation', with: 'testing'
      find(:xpath, '/html/body/article/form/p[9]/input').click
      sleep(0.1)
      expect(page).to have_content '登録しました！ようこそ！'
    end
  end

  describe 'セッション機能' do
    it 'ログインができる' do
      visit sessions_new_path
      sleep(0.1)
      fill_in 'session_email', with: 'user@user.com'
      fill_in 'session_password', with: '11111111'
      find(:xpath, '/html/body/article/form/p[5]/input').click
    end

    context '一般ユーザがログイン中の場合' do
      before do
        visit sessions_new_path
        fill_in 'session_email', with: 'user@user.com'
        fill_in 'session_password', with: '11111111'
        find(:xpath, '/html/body/article/form/p[5]/input').click
      end
      it '他人の詳細画面に飛ぶとタスク一覧画面に遷移する' do
        visit user_path(user.id + 1)
        sleep(0.1)
        expect(page).to have_content('一般ユーザー').and have_content('user@user.com')
        expect(page).not_to have_content('admin@admin.com')
      end

      it '自分の詳細画面(マイページ)に飛べる' do
        visit user_path(user.id)
        sleep(0.1)
        expect(page).to have_content('一般ユーザー').and have_content('user@user.com')
      end

      it 'ログアウトができる' do
        find(:xpath, '/html/body/header/ul/li[4]/a').click
        expect(page).to have_content('ログアウトしました').and have_content('Sign Up')
      end

    end
  end

  describe '管理画面機能' do
    context '管理者の場合' do
      before do
        visit sessions_new_path
        fill_in 'session_email', with: 'admin@admin.com'
        fill_in 'session_password', with: '11111111'
        find(:xpath, '/html/body/article/form/p[5]/input').click
        visit admin_users_path
      end
      it '管理画面にアクセスできる' do
        expect(page).to have_content('Administration').and have_content('ユーザー一覧画面')
      end

      it 'ユーザの新規登録ができる' do
        find(:xpath, '/html/body/p/a').click
        sleep(0.1)
        fill_in 'user_name', with: 'あああああ'
        fill_in 'user_email', with: 'test@test.com'
        select 'User', from: 'user_admin'
        fill_in 'user_password', with: 'testing'
        fill_in 'user_password_confirmation', with: 'testing'
        find(:xpath, '/html/body/article/form/p[11]/input').click
        sleep(0.1)
        expect(page).to have_content('Successfully created new user').and have_content('あああああ')
      end

      it 'ユーザの詳細画面にアクセスできる' do
        find(:xpath, '/html/body/article/table/tbody/tr[2]/td[5]/a').click
        sleep(0.2)
        expect(page).to have_content('一般ユーザー').and have_content('user@user.com').and have_content('User Authority')
      end

      it 'ユーザの編集画面からユーザを編集できる' do
        find(:xpath, '/html/body/article/table/tbody/tr[2]/td[6]/a').click
        sleep(0.1)
        fill_in 'user_name', with: 'Editing_Name'
        find(:xpath, '/html/body/article/form/p[11]/input').click
        sleep(0.1)
        expect(page).to have_content('Successfully updated the user!').and have_content('Editing_Name')
      end

      it 'ユーザの削除をできる' do
        find(:xpath, '/html/body/article/table/tbody/tr[2]/td[7]/a').click
        page.driver.browser.switch_to.alert.accept
        sleep(0.1)
        expect(page).to have_content 'Successfully deleted the user'
        expect(page).not_to have_content '一般ユーザー'
      end
    end

    context '一般ユーザの場合' do
      it '管理画面にアクセスできない' do
        visit sessions_new_path
        sleep(0.1)
        fill_in 'session_email', with: 'user@user.com'
        fill_in 'session_password', with: '11111111'
        find(:xpath, '/html/body/article/form/p[5]/input').click
        sleep(0.1)
        visit admin_users_path
        sleep(0.1)
        expect(page).to have_content('Not authorised to access the page').and have_content('件のタスクが登録されています。')
      end
    end
    
  end
end
