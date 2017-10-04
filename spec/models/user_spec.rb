require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Users creation' do

    describe 'creates users with assignee' do
      it 'is valid as reporter' do
        reporter = FactoryGirl.build(:user, :reporter)
        expect(reporter).to be_valid
      end

      it 'is valid as chief editor' do
        editor = FactoryGirl.build(:user, :chief_editor)
        expect(editor).to be_valid
      end

      it 'is valid as admin' do
        admin = FactoryGirl.build(:user, :admin)
        expect(admin).to be_valid
      end
    end


  end
end
