# Preview all emails at http://localhost:3000/rails/mailers/lunch_partnerr_mailer
class LunchPartnerrMailerPreview < ActionMailer::Preview

  def notify_partners_email
    emp = Employee.last
    LunchPartnerrMailer.with(emp: emp.id).notify_partners_email
  end
end
