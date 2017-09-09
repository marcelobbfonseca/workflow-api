class Task < ApplicationRecord
  belongs_to :lane, inverse_of: :tasks, dependent: :destroy
  has_one :sequence_flow, inverse_of: 'source', dependent: :nullify
  has_one :sequence_flow, inverse_of: 'target', dependent: :nullify

  enum category: [:startEvent, :userTask, :task, :exclusiveGateway, :endEvent]

end
