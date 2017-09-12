class BpmnController < ApplicationController
  before_action :set_user_tasks, only: [:parser]
  before_action :set_bpmn, only: [:parser]
  before_action :escape, only:[:parser, :create], if: "params['name']"
  rescue_from  Errno::ENOENT, with: :file_not_found

  def modeler

  end

  def viewer

  end
  # GET /bpmn/create
  # Create relational process from xml using nokogiri
  def create
    doc = Nokogiri::XML(File.open("#{Rails.root}/bpmn/processo_noticia.bpmn"))

    # Get process name
    puts doc.xpath('//bpmn:participant').first['name']
    business_process = BusinessProcess.create(name: doc.xpath('//bpmn:participant').first['name'])


    # Get process nodes, identify and create. Process lanes, lane nodes and sequence flows.
    process = doc.xpath('//bpmn:process')
    process.children.each do |node|

      #puts "node: #{node}"
      identify_and_create(node)
    end

    render json: {message: 'Business process was successfully created.'}, status: :created
    #respond_to do |format|
    #    format.html { render :index, notice: 'Business process was successfully created.' }
    #    format.json { render :show, status: :created }
    #end

  end

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

  def identify_and_create(node)
    return if node.name.eql? 'text' # trata node que pega espaçamento e \n

    if node.name.eql? 'laneSet'

      node.xpath('//bpmn:lane').each do |lane|   #bug
        puts lane['name'] # Lane.create(name: lane['name'])
        Lane.create(business_process: BusinessProcess.last, name: lane['name'])
        lane.xpath('//bpmn:flowNodeRef').each do |lane_task|

          # puts "Nodo de #{lane['name']} : #{lane_task.text}"
          task = Task.create(xml_id: lane_task.text, lane_id: Lane.last.id )
          render json:{message: task.errors} unless task.save
        end
      end

    elsif node.name.eql? 'sequenceFlow'
      byebug
      source = Task.find_by_xml_id(node['sourceRef'])
      target = Task.find_by_xml_id(node['targetRef'])
      sequence = SequenceFlow.find_or_initialize_by(xml_id: node['id'])
      sequence.source = source
      sequence.target = target
      render json: {message: sequence.errors} unless sequence.save
    else

      task = Task.find_by_xml_id(node['id'])
      task.category = node.name
      task.content = node['name']
      render json: {message:task.errors} unless task.save

    end

  end


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

  def process_name(doc)
    doc.css('bpmn|participant').first['name']
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def escape
    @name = params[:name].gsub(/[^0-9A-Za-z]/, '')
  end

end
