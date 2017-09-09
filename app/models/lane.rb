class Lane < ApplicationRecord
  has_many :tasks, inverse_of: :lane, dependent: :nullify
  belongs_to :business_process, inverse_of: :lanes, dependent: :destroy

end
