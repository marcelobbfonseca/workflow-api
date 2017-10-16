
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

Require MySQL

 How to Use:
 1. Start localhost server
 	$ git clone https://github.com/marcelobbfonseca/workflow-api.git
	$ cd workflow-api
	$ bundle install
	$ rails db:seed # add users admin, reporter and chief-editor
	$ rails server
	
Access server running on http://localhost:3000

Modeling a new BPD with bpmn-js. Access http://localhost:3000/bpmn/modeler
Save file and image localy in yor computer

Go to http://localhost:3000/admin

Select Diagram
Create new diagram using the file and image saved.


	
