
# README

# workflow-api
Building a BPMN workflow API for rails 5.1


Application in progress.
This README will document all necessary steps to get the
application up and running.

* Ruby version: 2.3.3

* Rails version: 5.1

* OS: Linux Mint 17.3

* Database: MySQL 5.7
	
	instalation:
	https://www.howtoforge.com/tutorial/how-to-install-mysql-57-on-linux-centos-and-ubuntu/


* Configuration

* adapter mysql2

* Using webpacker for bpmn libraries

* Will be using rspec for test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* In progress: working on two endpoints for bpmn xml parsing and view for bpmn-js modeling. 

Dependencies: 
* MySQL
* Yarn

 How to Use:
 1. Start localhost server
 
 		$ git clone https://github.com/marcelobbfonseca/workflow-api.git
		$ cd workflow-api
		$ bundle install
		$ rails db:seed # add users admin, reporter and chief-editor
		$ yarn  # run yarn to compile webpacker
		$ rails server
	
Access server running on http://localhost:3000

Modeling a new BPD with bpmn-js. Access http://localhost:3000/bpmn/modeler
Save file and image localy in yor computer

2.Create Business Process

* Go to http://localhost:3000/admin
* email: admin@admin.com password: 12344321

Select Diagrams ("http://localhost:3000/admin/diagram")
Create new diagram using the file and image saved, or just use one of the projects diagrams on bpmn folder.
For this study case, upload the diagrama_multi.svg and ProducaoNoticiaWebMulti.bpmn located on workflow-api/bpmn directory.

The MySQL database is already setup. Uploading the diagram xml file("ex:ProducaoDaNoticia.bpmn") as paramater to the framework endpoint will create a business process for it on the relational database. 
Access the route below to create a Business Process for your diagram.bpmn:
	
	GET http://localhost:3000/bpmn/create.json?name="bpmn_file_name"
For our example we will be using ProducaoDaNoticia.bpmn file, so it will be like this:
	
	GET http://localhost:3000/bpmn/create.json?name=ProducaoDaNoticia

After that it should send a "Business Process Created." message.
If you checkout your admin dashboard, there should be 1 new Business Process and all it's tasks and SequenceFlows created. 

3.Assign user to a task

Still on admin dashboard click on Tasks ("http://localhost:3000/admin/task")
Select the userTask pré-apura pauta to edit and assign user Aroldo, a reporter.

4. Upload Ontology
	On admin dashboard, go to Ontologies and select create.("http://localhost:3000/admin/ontology/new")
	Create a new ontologies with:
	File: On Ontologies directory, upload multi_newsroom.owl
	prefix: http://semanticworkflow-api.herokuapp.com/multi-newsroom#
	name: leave it blank.

The framework is now all setup.
5. Automatic role suggestion
	Go to http://localhost:3000/ontologies view and select "show" on the ontology recently created.
	Just like in step 2. type the diagram name on the form to search the most suitable usertasks role for the diagram's task's. It will make a SparQL querie in the ontology for each usertask on the diagram and show the result in an array.


6. Endpoints

 
 Get Busines Process and all lanes and tasks. 1 = BusinessProcess id
	
		GET http://localhost:3000/business_processes/1.json


 Update Business Process current task to a next task with current_task id=22 and BusinessProcess id=1.
 		
		PUT http://localhost:3000/business_processes/5.json
		

 		{
			"business_process":{
				"current_task_id": 22
			}
	
		}

 
 Get task information and existing nexts tasks
 	
		GET localhost:3000/tasks/26.json
	
 Creates a new Business with bpmn file name as params 
 
		GET http://localhost:3000/bpmn/create.json?name=ProducaoNoticiaWebMulti
