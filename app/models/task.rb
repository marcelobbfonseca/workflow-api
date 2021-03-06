class Task < ApplicationRecord
  belongs_to :lane, inverse_of: :tasks, optional: true
  belongs_to :assignee, class_name: 'User', foreign_key: 'user_id', inverse_of: :tasks, optional: true

  has_many :next_sequence_flows, class_name: 'SequenceFlow', foreign_key: 'source_id', inverse_of: 'source', dependent: :destroy
  has_many :next_tasks, class_name: 'Task', through: :next_sequence_flows, source: :target

  has_many :previous_sequence_flows, class_name: 'SequenceFlow', foreign_key: 'target_id', inverse_of: 'target', dependent: :destroy
  has_many :previous_tasks, class_name: 'Task', through: :previous_sequence_flows, source: :source

  has_one :business_process, foreign_key: 'current_task_id', inverse_of: :current_task

  before_create :set_inactive
  before_save :clean_new_line, if: Proc.new { self.content.present? }

  enum category: [:startEvent, :userTask, :task, :exclusiveGateway, :endEvent]
  enum status:[ :inactive ,:started, :completed, :aborted ]

  rails_admin do
    object_label_method do
      :get_name
    end

  end

  def get_name
    self.content
  end
  private

  def set_inactive
    self.status = :inactive
  end

  def clean_new_line
    self.content = content.gsub(/\n/, '')
  end

end
