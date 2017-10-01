module BpmnDirFileHandler
  extended ActiveSupport::Concern

  # delete unwanted . and .. from array
  def bpmn_files
    Dir.entries("#{Rails.root}/bpmn/").delete_if{|a| a.eql? '.' or a.eql? '..'}
  end

  def remove_new_line(name)
    name.gsub(/\n/, '')
  end

  # temp

  def parser_(name)
    bpmn = Array.new
    userTasks = Array.new

    doc = Nokogiri::XML(File.open("#{Rails.root}/bpmn/processo_noticia.bpmn")) if name.nil?
    doc = Nokogiri::XML(File.open("#{Rails.root}/bpmn/#{name}.bpmn")) unless name.nil?

    # Get process name
    process = process_name_(doc)


    # Get all user tasks
    # task.content for xml content
    doc.css('bpmn|userTask').each do |task|
      userTasks.push(task['name'])
    end

    # build bpmn query array
    bpmn.push(process: process).push(userTask: userTasks)
  end

  def process_name_(doc)
    doc.css('bpmn|participant').first['name']
  end

end