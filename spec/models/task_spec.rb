require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'Creates activities' do

    describe 'creating usertasks' do

      it 'is valid as usertask' do
        task = FactoryGirl.build(:task, :user_task)
        expect(task).to be_valid
      end

      it 'is valid with reporter assignee' do
        task = FactoryGirl.build(:task, :with_reporter_assignee)
        expect(task.assignee).to_not be nil
      end

      it 'is expected to create as inactive' do
        task = FactoryGirl.create(:task)
        expect(task.inactive?).to be true
      end
    end

  end

end
