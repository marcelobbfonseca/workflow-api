class Ontology < ApplicationRecord
  mount_uploader :path_name, OntologyUploader # Tells rails to use this uploader for this model.
  validates :name, presence: true # Make sure the owner's name is present.



end
