class BusinessProcess < ApplicationRecord
  belongs_to :current_task, class_name: 'Task' , foreign_key: 'current_task_id', optional: true
  has_many :lanes, inverse_of: :business_process, dependent: :destroy
  belongs_to :diagram, inverse_of: :business_processes, dependent: :destroy, optional: true
  has_many :tasks, through: :lanes, dependent: :destroy
  before_create :set_first_process_task
  before_update :update_current_task




  def start_event
    self.tasks.find_by_category :startEvent
  end

  private
  def set_first_process_task
    self.current_task = start_event
  end

  def update_current_task

    previous = self.current_task.previous_tasks.find_by_status(:started)
    if previous.present?
      previous.update(status: :completed)
      self.current_task.update(status: :started)
    else
      throw :abort
    end

  end
end
