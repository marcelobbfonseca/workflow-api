class User < ApplicationRecord
  has_many :tasks, inverse_of: :assignee

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:admin, :api_consumer, :reporter, :chief_editor ]

end
