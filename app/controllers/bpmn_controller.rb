class BpmnController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_user_tasks, only: [:parser]
  before_action :set_bpmn, only: [:parser]
  before_action :set_diagram, only:[:parser, :create], if: "params['name']"
  rescue_from  Errno::ENOENT, with: :file_not_found
  include BpmnHelper
  include BpmnDirFileHandler

  # bpmn-js modeler
  def modeler
  end

  # bpmn-js viewer
  def viewer
  end

  # GET /bpmn/create
  # Create relational process from xml using nokogiri
  def create
    doc = Nokogiri::XML(File.open(@diagram.file.path)) if @diagram.present?
    doc = Nokogiri::XML(File.open("#{Rails.root}/bpmn/processo_noticia.bpmn")) if @diagram.nil?

    # Get process name
    business_process = BusinessProcess.create(name: process_name_(doc))
    render json:{message: business_process.errors}  if business_process.errors.any?

    # Get process nodes, identify and create. Process lanes, lane nodes and sequence flows.
    process = doc.xpath('//bpmn:process')
    process.children.each do |node|
      identify_and_create(node)
    end

    render json: {message: 'Business process was successfully created.'}, status: :created

  end

  # will parse a bpmn file and return usertasks and process name for SparQL using nokogiri
  def parser
    @bpmn = parser_

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
    render json: {message: "Process #{@name} not found. Existing files:#{bpmn_files}"}, status: :not_found
  end

  def process_name(doc)
    doc.css('bpmn|participant').first['name']
  end

  # Never trust parameters from the scary internet, only allow the white list through.

  def set_diagram
    name = escape_(params[:name])
    @diagram =Diagram.find_by_name(name)
  end

end
