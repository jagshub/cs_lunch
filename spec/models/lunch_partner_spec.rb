require "rails_helper"

RSpec.describe LunchPartner, :type => :model do
  describe "Associations" do
    it { should belong_to(:employee) }
    it { should belong_to(:lunch_group) }
  end

  describe "Mystery lunch partners creation" do

    it 'verifies mystery lunch partner selection' do
      create_list(:department, 7)
      create_list(:employee, 6)

      LunchPartner.create_mystery_lunches(Date.today)

      Employee.all.each do |emp|
        expect(Employee.fetch_partners(emp.id).count).to be >0
        expect(Employee.where(id: Employee.fetch_partners(emp.id)).map(&:department_id).include?(emp.department_id)).to be_falsey
      end
    end

    it 'verifies lunch partner count' do
      create_list(:department, 7)
      create_list(:employee, 6)

      LunchPartner.create_mystery_lunches(Date.today)
      expect(LunchPartner.count).to eq(6)
    end

    it 'verifies lunch group count' do
      create_list(:department, 7)
      create_list(:employee, 11)

      LunchPartner.create_mystery_lunches(Date.today)
      expect(LunchGroup.count).to eq(5)
    end
  end
end
