class BpmnController < ApplicationController
  before_action :set_user_tasks, only: [:parser]
  before_action :set_bpmn, only: [:parser]
  before_action :escape, only:[:parser], if: "params['name']"
  rescue_from  Errno::ENOENT, with: :file_not_found

  def modeler

  end

  def viewer

  end

  def parser
    doc = Nokogiri::XML(File.open("#{Rails.root}/bpmn/processo_noticia.bpmn")) if @name.nil?
    doc = Nokogiri::XML(File.open("#{Rails.root}/bpmn/#{@name}.bpmn")) unless @name.nil?

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

  private

  def set_user_tasks
    @userTasks = Array.new
  end

  def set_bpmn
    @bpmn = Array.new
  end

  def file_not_found
    @files = Dir.entries("#{Rails.root}/bpmn/")
    respond_to do |format|
      format.json { render json: "Process #{@name} not found. Existing files:#{@files}" }
      format.html { render json: "Process #{@name} not found. Existing files:#{@files}", status: :not_found }
    end

  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def escape
    @name = params[:name].gsub(/[^0-9A-Za-z]/, '')
  end
end
