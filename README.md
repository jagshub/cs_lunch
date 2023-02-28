# Creditshelf mystery lunch


**Getting started**

To get started with the app, clone the repo and then install the needed gems:
 
`bundle install`

**Setup db**

`rails db:setup`

`rails db:migrate`


`rake db:seed`  
_This sets up some lunch partners for previous months_

**Automated Mystery lunch partner generation**   
Whenever gem is used to setup automated jobs (cron)
Currently this is set to run every minute in development.    
Please check schedule.rb comments to run every month.

**Run this command to create the cronjob.**  
Mystery lunch for current month should be created in 1 minute.  
`whenever --update-crontab --set environment=development`

**Start the app**  
rails s

**Home Page**  
* Go to http://127.0.0.1:3000/
* Lists partners as seperate rows
* used ActiveStorage for images
* Implemented filter by dept. Show partners when one of them
  falls in the selected department.
* See all previous partners
* 

**Manage Employees**  
* Use password `admin` to access manage page
* Create, Edit, delete, restore employees
* Delete a employee, then click Home and check how the partners
  are moved to another lunch group.


**Note: The app also works with docker, see DOCKER-README.md for  
instructions**


