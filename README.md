# Creditshelf mystery lunch


**Getting started**

To get started with the app, clone the repo and then install the needed gems:
 
bundle install

**Setup db**

rails db:setup

rails  db:migrate

**Setup employees and departments**

rake db:seed

**Setup automated job using whenever**

Development
whenever --update-crontab --set environment=development

Production
whenever --update-crontab

**Run app**

rails s
