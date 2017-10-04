class BusinessProcess < ApplicationRecord
  belongs_to :current_task, class_name: 'Task' , foreign_key: 'current_task', optional: true
  has_many :lanes, inverse_of: :business_process, dependent: :nullify
  belongs_to :diagram, inverse_of: :business_processes, dependent: :destroy, optional: true
  has_many :tasks, through: :lanes
  before_save :clean_new_line
  before_create :set_first_process_task



  def clean_new_line
    self.name = name.gsub(/\n/, '')
  end

  def start_event
    self.tasks.find_by_category :startEvent
  end

  private
  def set_first_process_task
    self.current_task = start_event
  end

end
