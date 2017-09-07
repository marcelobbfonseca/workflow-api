class BpmnController < ApplicationController
  before_action :set_user_tasks, only: [:parser]
  before_action :set_bpmn, only: [:parser]

  def modeler

  end

  def viewer

  end

  def parser
    doc = Nokogiri::XML(File.open("#{Rails.root}/bpmn/processo_noticia.bpmn"))

    # Get process name
    @process = doc.css('bpmn|participant').first['name']

    # Get all user tasks
    # task.content for xml content
    doc.css('bpmn|userTask').each do |task|
      @userTasks.push(task['name'])
    end

    # build bpmn query array
    @bpmn.push(process: @process).push(userTask: @userTasks)
    respond_to do |format|
      format.json { render json: @bpmn }
      format.html { render json: @bpmn }
    end

  end

  def set_user_tasks
    @userTasks = Array.new
  end

  def set_bpmn
    @bpmn = Array.new
  end

end
