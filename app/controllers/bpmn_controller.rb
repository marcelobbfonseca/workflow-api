class BpmnController < ApplicationController
  before_action :set_user_tasks, only: [:parser]
  before_action :set_bpmn, only: [:parser]
  before_action :escape, only:[:parser, :create], if: "params['name']"
  rescue_from  Errno::ENOENT, with: :file_not_found
  include BpmnHelper

  # bpmn-js modeler
  def modeler
  end

  # bpmn-js viewer
  def viewer
  end

  # GET /bpmn/create
  # Create relational process from xml using nokogiri
  def create
    doc = Nokogiri::XML(File.open("#{Rails.root}/bpmn/processo_noticia.bpmn"))

    # Get process name
    business_process = BusinessProcess.create(name: doc.xpath('//bpmn:participant').first['name'])

    # Get process nodes, identify and create. Process lanes, lane nodes and sequence flows.
    process = doc.xpath('//bpmn:process')
    process.children.each do |node|
      identify_and_create(node)
    end

    render json: {message: 'Business process was successfully created.'}, status: :created

  end

  # will parse a bpmn file and return usertasks and process name for SparQL using nokogiri
  def parser
    doc = Nokogiri::XML(File.open("#{Rails.root}/bpmn/processo_noticia.bpmn")) if @name.nil?
    doc = Nokogiri::XML(File.open("#{Rails.root}/bpmn/#{@name}.bpmn")) unless @name.nil?

    # Get process name
    @process = process_name(doc)


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
    dir_files = Dir.entries("#{Rails.root}/bpmn/")
    render json: {message: "Process #{@name} not found. Existing files:#{dir_files}"}, status: :not_found
  end

  def process_name(doc)
    doc.css('bpmn|participant').first['name']
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def escape
    @name = params[:name].gsub(/[^0-9A-Za-z]/, '')
  end

end
