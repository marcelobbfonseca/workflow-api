class Ontology < ApplicationRecord
  mount_uploader :path_name, OntologyUploader # Tells rails to use this uploader for this model.
  validates_presence_of :name
  validates_presence_of :prefix


end
