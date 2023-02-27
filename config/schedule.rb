# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "log/cron_log.log"

#
# Uncomment/comment line:18 and line:20, to create partners every minute or once a month
#
# 1. Run in console to remove current month partners
#    LunchGroup.where('lunch_date > ?', Date.today.beginning_of_month).destroy_all
#    LunchPartner.where(month: :February).destroy_all
# 2. update crontab
#    whenever --update-crontab --set environment=development

ENV.each { |k, v| env(k, v) }
#Create mystery lunches every 1 of month.
# every 1.month, :at => "1 AM" do
every 1.minutes do
  runner "LunchPartner.create_mystery_lunch_for_current_month"
end