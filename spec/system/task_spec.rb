require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  let!(:task) { FactoryBot.create(:task ) }
  let!(:second_task) { FactoryBot.create(:second_task ) }

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_name', with: 'make a test'
        fill_in 'task_detail', with: 'test_test_test'
        fill_in 'task_expire_on', with: '002021/10/08'
        select '着手中', from: 'task[status]'
        click_on '登録する'
        visit tasks_path
        expect(page).to have_content 'test_test_test' && '2021-10-08' && '着手中'
      end
    end
  end

  describe '一覧表示機能' do
    before { visit tasks_path }
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task1'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'task2'
        expect(task_list[1]).to have_content 'task1'
      end
    end
    context 'Sort by Deadline をクリックした場合' do
      it '終了期限が降順（遠い期限のものが上）に表示される' do
        click_on 'Sort by Deadline'
        deadline_list = all('.task_row')
        expect(deadline_list[0]).to have_content '2021-08-16'
        expect(deadline_list[1]).to have_content '2021-07-01'
      end
    end
    context 'Sort by Priority をクリックした場合' do
      it '優先順位が高いものから順番に表示される' do
        # @wait.until do
          click_on 'Sort by Priority'
        # end
        priority_list = all('.task_row')
        expect(priority_list[0]).to have_content '高'
        expect(priority_list[1]).to have_content '中'
      end
    end
  end

  describe '検索機能' do
    before { visit tasks_path }
    context 'タスク名で検索した場合' do
      it 'タスク名が含まれるタスク一覧が表示される' do
        fill_in 'name_search', with: 'task1'
        click_on 'Search'
        expect(page).to have_content 'test1'
      end
    end
    context 'ステータスで検索した場合' do
      it 'ステータスに一致したタスク一覧が表示される' do
        select '完了', from: 'status_search'
        click_on 'Search'
        expect(page).to have_content 'task2'
      end
    end
    context 'タスク名とステータス両方で検索した場合' do
      it 'タスク名を含み、ステータスが合致するタスク一覧が表示される' do
        fill_in 'name_search', with: 'task'
        select '完了', from: 'status_search'
        click_on 'Search'
        expect(page).to have_content 'test2'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(second_task.id)
        expect(page).to have_content 'test2'
      end
    end
  end
end
