class BusinessProcess < ApplicationRecord
  belongs_to :current_task, class_name: 'Task', foreign_key: 'current_task', optional: true
  has_many :tasks, inverse_of: :business_process, dependent: :nullify
end
