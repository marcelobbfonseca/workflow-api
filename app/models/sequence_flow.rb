class SequenceFlow < ApplicationRecord
  belongs_to :target, class_name: 'Task', foreign_key: 'target', inverse_of: :sequence_flow, optional: true, dependent: :destroy
  belongs_to :source, class_name: 'Task', foreign_key: 'source', inverse_of: :sequence_flow, optional: true, dependent: :destroy
end
