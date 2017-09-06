class BpmnController < ApplicationController

  def modeler

  end

  def viewer

  end

  def bpmn_parser
    #doc = File.open("#{Rails.root}/bpmn/producao_noticia.bpmn") { |f| Nokogiri::XML(f) }
    doc = Nokogiri::XML(File.open("#{Rails.root}/bpmn/processo_noticia.bpmn"))
    byegbug
    doc.css('bpmn|userTask').each do |task|
      puts task['name']
      puts task.content
    end

  end
end
