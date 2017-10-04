class SequenceFlow < ApplicationRecord
  belongs_to :target, class_name: 'Task', foreign_key: 'target_id', inverse_of: :previous_sequence_flows, optional: true
  belongs_to :source, class_name: 'Task', foreign_key: 'source_id', inverse_of: :next_sequence_flows, optional: true

  rails_admin do
    edit do
      field :target
      field :source
      field :xml_id
    end
    list do
      field :target
      field :source
      field :xml_id
    end
    show do
      field :target
      field :source
      field :xml_id
    end
  end

end
