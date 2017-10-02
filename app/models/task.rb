class Task < ApplicationRecord
  belongs_to :lane, inverse_of: :tasks, dependent: :destroy
  has_many :previous_sequence_flows, class_name: 'SequenceFlow', inverse_of: 'source', dependent: :nullify
  has_many :next_sequence_flows, class_name: 'SequenceFlow', inverse_of: 'target', dependent: :nullify
  #has_many
  enum category: [:startEvent, :userTask, :task, :exclusiveGateway, :endEvent]

  rails_admin do
    object_label_method do
      :get_name
    end
    edit do
      field :category
      field :content
    end
    show do
      field :category
      field :content
    end
    list do
      field :category
      field :content
    end
  end

  def get_name
    self.content
  end
end
