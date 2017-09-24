module BpmnDirFileHandler
  extended ActiveSupport::Concern

  # delete unwanted . and .. from array
  def bpmn_files
    Dir.entries("#{Rails.root}/bpmn/").delete_if{|a| a.eql? '.' or a.eql? '..'}
  end

  def remove_new_line(name)
    name.gsub(/\n/, '')
  end

end