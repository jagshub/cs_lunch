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

`$ crontab -l`
```


# Begin Whenever generated tasks for: /Users/jag/workspace/cs_lunch/config/schedule.rb at: 2023-02-27 18:34:52 +0530
* * * * * /bin/bash -l -c 'cd /Users/jag/workspace/cs_lunch && bundle exec bin/rails runner -e development '\''LunchPartner.create_mystery_lunch_for_current_month'\'' >> log/cron_log.log 2>&1'

# End Whenever generated tasks for: /Users/jag/workspace/cs_lunch/config/schedule.rb at: 2023-02-27 18:34:52 +0
```


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


**New Feature - Email notification**  
Send email with partner information to each employee  
You can see the preview of the email here  
http://localhost:3000/rails/mailers/lunch_partnerr_mailer/notify_partners_email  

* mails are sent out when partners are generated
  see development.log. Sample from devlopment.log
```
[ActiveJob] [ActionMailer::MailDeliveryJob] [e9aaf054-d59c-4a97-b369-27cac62d1ca0] Delivered mail 63fddf4a6702a_ca354628427cd@jag-3.local.mail (3142.2ms)
[ActiveJob] [ActionMailer::MailDeliveryJob] [e9aaf054-d59c-4a97-b369-27cac62d1ca0] Date: Tue, 28 Feb 2023 16:32:34 +0530^M
From: admin@creditshelf.com^M
To: gonzalo@beier.info^M
Message-ID: <63fddf4a6702a_ca354628427cd@jag-3.local.mail>^M
Subject: Your lunch partner(s) this month!^M
Mime-Version: 1.0^M
Content-Type: text/html;^M
 charset=UTF-8^M
Content-Transfer-Encoding: 7bit^M
^M
<!DOCTYPE html>^M
<html>^M
  <head>^M
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />^M
    <style>^M
      /* Email styles need to be inline */^M
    </style>^M
  </head>^M
^M
  <body>^M
    <!DOCTYPE html>^M
<html>^M
<head>^M
  <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />^M
</head>^M
<body>^M
<p>Your lunch partners for this month!</p>^M
<p>^M
</p>^M
^M
```

**Note: The app also works with docker, see DOCKER-README.md for  
instructions**


