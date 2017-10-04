module BpmnHelper
  # Get process nodes, identify and create. Process lanes, lane nodes and sequence flows.
  def identify_and_create(node)
    return if node.name.eql? 'text' # trata node que pega espaçamento e \n

    if node.name.eql? 'laneSet'

      node.xpath('//bpmn:lane').each do |lane|   #bug
        puts lane['name'] # Lane.create(name: lane['name'])
        Lane.create(business_process: BusinessProcess.last, name: lane['name'])
        lane.text.split(' ').each do |lane_task|
          task = Task.create(xml_id: lane_task, lane_id: Lane.last.id )
          render json:{message: task.errors} unless task.save
        end
      end

    elsif node.name.eql? 'sequenceFlow'

      #source = Task.find_by_xml_id(node['sourceRef'])
      #target = Task.find_by_xml_id(node['targetRef'])
      source = Task.where(xml_id: node['sourceRef']).last
      target = Task.where(xml_id: node['targetRef']).last
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

end
