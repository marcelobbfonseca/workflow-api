class BusinessProcess < ApplicationRecord
  belongs_to :current_task, class_name: 'Task', foreign_key: 'current_task', optional: true
  has_many :lanes, inverse_of: :business_process, dependent: :nullify
  belongs_to :diagram, inverse_of: :business_processes, dependent: :destroy

  before_save :clean_new_line




  def clean_new_line
    self.name = name.gsub(/\n/, '')
  end

end
