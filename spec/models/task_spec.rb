require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', detail: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
      context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '失敗テスト', detail: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: '成功テスト', detail: '成功')
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task ) }
    let!(:second_task) { FactoryBot.create(:second_task ) }
    let!(:third_task) { FactoryBot.create(:third_task ) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.by_name('task1')).to include(task)
        expect(Task.by_name('task1')).not_to include(second_task)
        expect(Task.by_name('task2').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.by_status('着手中')).to include(task)
        expect(Task.by_status('完了')).not_to include(task)
        expect(Task.by_status('完了').count).to eq 2
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.by_name('task1').by_status('完了')).to include(third_task)
        expect(Task.by_name('task1').by_status('着手中')).not_to include(second_task)
        expect(Task.by_name('task1').by_status('着手中').count).to eq 1
      end
    end
  end
end
