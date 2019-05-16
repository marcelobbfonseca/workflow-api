
[![forthebadge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
[![Build Status](https://travis-ci.com/marcelobbfonseca/workflow-api.svg?branch=master)](https://travis-ci.com/marcelobbfonseca/workflow-api) [![Depfu](https://badges.depfu.com/badges/162afd397ea7f132bc73bb87dbc689d0/status.svg)](https://depfu.com) [![Depfu](https://badges.depfu.com/badges/162afd397ea7f132bc73bb87dbc689d0/count.svg)](https://depfu.com/github/marcelobbfonseca/workflow-api?project_id=7786) [![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

# semantic workflow-api
This project is a semantic BPMN workflow API for rails 5.1 and a part of this [article](http://ceur-ws.org/Vol-2228/short4.pdf) . The application comes with rails-admin interface and a view for BPMN modeling tool from [bpmn-js](https://bpmn.io/toolkit/bpmn-js/). 
The main goal of this app is to assist the diagram modeling with a domain ontology(.owl file extension). The ontology used for this app was made using [PRÓTÉGÉ](https://protege.stanford.edu/) modeling tool and defines a few tasks inside a newsroom. If theres no interest in using semantic tools, you can still use this project as a Workflow API for Ruby on Rails




### preview running in
https://semanticworkflow-api.herokuapp.com/ (maintenance)


## Requirements

* Ruby version: 2.5.0

* Database: MySQL 5.7

* Rails version: 5.1


Ruby version can be correctly chosen by installing rvm or rbenv. MySQL also needs to be installed and running. After installing ruby and MySQL install rails.
```
	gem install rails -v 5.1
```

## Configuration

* mysql2 adapter 

* Using webpacker for bpmn libraries

* Will be using rspec for test suite

* Services (Dockerfile will be added soon.)

* Deployment instructions

* In progress

Dependencies: 
* Ruby 2.5.0 
* Ruby on Rails 5.1 +
* MySQL 5.7
* Yarn or npm
* Node 6.4.0 +
 How to Use:
 # 1. Start localhost server
```
	$ git clone https://github.com/marcelobbfonseca/workflow-api.git
	$ cd workflow-api
	$ bundle install
```
You will need to change MySQL ```username``` and ```password``` config in ```workflow-api/config/database.yml``` to your local MySQL credentials in your machine. The next step is to run database seed and start local server.
```		
		$ rails db:seed # add users admin, reporter and chief-editor
		$ yarn  # run yarn to compile webpacker
		$ rails server
```

Access server running in ```http://localhost:3000```

Modeling a new BPD with bpmn-js. Access http://localhost:3000/bpmn/modeler
Save file and image localy in yor computer

# 2.Create Business Process

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

# 3.Assign user to a task

Still on admin dashboard click on Tasks ("http://localhost:3000/admin/task")
Select the userTask pré-apura pauta to edit and assign user Aroldo, a reporter.

# 4. Upload Ontology

On admin dashboard, go to Ontologies and select create.("http://localhost:3000/admin/ontology/new")
Create a new ontologies with:
* File: On Ontologies directory, upload multi_newsroom.owl
* prefix: http://semanticworkflow-api.herokuapp.com/multi-newsroom#
* name: multi_newsroom

The framework is now all setup.
# 5. Automatic role suggestion

Go to http://localhost:3000/ontologies view and select "show" on the ontology recently created.
Just like in step 2. type the diagram name on the form to search the most suitable usertasks role for the diagram's task's. It will make a SparQL querie in the ontology for each usertask on the diagram and show the result in an array.


# 6. Endpoints
 
 Get Busines Process and all lanes and tasks. 1 = BusinessProcess id
```	
		GET http://localhost:3000/business_processes/1.json
```

 Update Business Process current task to a next task with current_task id=22 and BusinessProcess id=1.

 ```		
		PUT http://localhost:3000/business_processes/5.json
		
 		{
			"business_process":{
				"current_task_id": 22
			}
	
		}
```
 
 Get task information and existing nexts tasks
 	
 ```		
		GET localhost:3000/tasks/26.json
 ```		
	
 Creates a new Business with bpmn file name as params 
 
 ```		
		GET http://localhost:3000/bpmn/create.json?name=ProducaoNoticiaWebMulti
 ```		
		
Get user with id = 1 data and all his tasks assigned to.
		
 ```		
		GET http://localhost:3000/users/1.json
 ```		
		
		


### If there's any trouble trying to run the project, create a new issue.
