# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "log/cron_log.log"

#Create mystery lunched every 1 of month.
every 1.month, :at => "1 AM" do
  runner "LunchPartner.create_mystery_lunch_for_current_month"
end