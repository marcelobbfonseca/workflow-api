class Lane < ApplicationRecord
  has_many :tasks, inverse_of: :lane, dependent: :nullify
  belongs_to :business_process, inverse_of: :lanes, dependent: :destroy
  before_save :clean_new_line

  private

  def clean_new_line
    self.name = name.gsub(/\n/, '')
  end

end
