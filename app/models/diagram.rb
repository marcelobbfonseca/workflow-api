class Diagram < ApplicationRecord
  has_many :business_processes, inverse_of: :diagram

  mount_uploader :file, DiagramUploader # Tells rails to use this uploader for this model.
  mount_uploader :image, DiagramUploader
  validates_presence_of :file
  before_save :get_name


  rails_admin do
    edit do
      include_all_fields
      field :name do
        read_only true
      end
    end

  end

  private
  def get_name
    self.name = self.file.path.split('/').last.split('.').first
  end
end
