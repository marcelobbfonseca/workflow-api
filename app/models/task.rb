class Task < ApplicationRecord
  belongs_to :lane, inverse_of: :tasks, dependent: :destroy, optional: true
  # has_one :business_process, inverse_of: :task
  has_many :next_sequence_flows, class_name: 'SequenceFlow', foreign_key: 'source_id', inverse_of: 'source', dependent: :nullify
  has_many :next_tasks, class_name: 'Task', through: :next_sequence_flows, source: :source

  has_many :previous_sequence_flows, class_name: 'SequenceFlow', foreign_key: 'target_id', inverse_of: 'target', dependent: :nullify
  has_many :previous_tasks, class_name: 'Task', through: :previous_sequence_flows, source: :target
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
end
