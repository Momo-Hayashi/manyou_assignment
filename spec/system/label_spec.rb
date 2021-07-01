require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do

  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user ) }
  let!(:second_task) { FactoryBot.create(:second_task, user: user ) }

  before do
    visit sessions_new_path
    fill_in 'session_email', with: 'user@user.com'
    fill_in 'session_password', with: '11111111'
    find(:xpath, '/html/body/article/form/p[5]/input').click
  end

  describe 'ラベルの登録' do
    it '新規タスク作成でラベルをつけられる' do
      visit new_task_path
      sleep(0.1)
      fill_in 'task_name', with: 'make a test'
      fill_in 'task_detail', with: 'test_test_test'
      fill_in 'task_expire_on', with: '002021/10/08'
      select '着手中', from: 'task[status]'
      page.check 'Family'
      page.check 'Work'
      find(:xpath, '/html/body/form/article/input').click
      sleep(0.1)
      expect(page).to have_content('Succesfully created the task!')
      expect(page).to have_selector '.labels', text: 'Family' && 'Work'
    end
    it '既存のタスクのラベルを更新できる' do
      find(:xpath, '/html/body/article/table/tbody/tr[2]/td[7]/a').click
      sleep(0.1)
      uncheck 'Family'
      check 'Hobby'
      find(:xpath, '/html/body/form/article/input').click
      sleep(0.1)
      expect(page).to have_content('Succesfully updated the task!')
      expect(page).to have_selector '.labels', text: 'Hobby'
      expect(page).not_to have_selector '.labels', text: 'Family'
    end
  end

  describe 'ラベルで検索' do
    it '指定したラベルに一致したタスク一覧が表示される' do
      select 'Work', from: 'label_search'
      find(:xpath, '/html/body/article/form/input[3]').click
      sleep(0.1)
      expect(page).to have_selector '.content', text: 'test1'
    end
  end

  describe '詳細表示機能' do
    it 'タスクの詳細画面で登録したラベルが全て表示される' do
      find(:xpath, '/html/body/article/table/tbody/tr[4]/td[6]/a').click
      sleep(0.1)
      expect(page).to have_content('Hobby').and have_content('Work')
    end
  end

end
