module Utils
  def self.first_friday(date = nil)
    date = date.nil? ? Date.today.beginning_of_month : date.beginning_of_month
    date += (5 - date.wday) % 7
    date
  end
end