class LunchPartnerrMailer < ApplicationMailer
  def notify_partners_email
    @emp = Employee.find(params[:emp])
    @partners = Employee.fetch_partners(@emp.id)

    mail(to: @emp.email, subject: "Your lunch partner(s) this month!")
  end
end
