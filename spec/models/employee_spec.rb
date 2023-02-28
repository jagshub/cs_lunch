require "rails_helper"

RSpec.describe Employee, :type => :model do
  subject do

    described_class.new(name: "Anything",
                        image: Rack::Test::UploadedFile.new('spec/support/test_image.png', 'image/png'),
                        image_url: 'http://image.png',
                        department: Department.create(name: 'HR'))
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a dept" do
    subject.department = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:department) }
    it { should have_many(:lunch_groups) }
    it { should have_many(:lunch_partners) }
  end

  describe "partners" do
    it 'verifies partners' do
      create_list(:department, 7)
      create_list(:employee, 6)
      emp = Employee.first
      pair = Employee.where.not(department_id: emp.department_id).sample

      grp = LunchGroup.create!(lunch_date: Utils::first_friday(Date.today), created_at: Date.today)
      LunchPartner.create!(lunch_group: grp, employee: emp, department_id: emp.department.id, month: Date.today.strftime('%B'), created_at: Date.today)
      partner = LunchPartner.create!(lunch_group: grp, employee: pair, department_id: pair.department_id, month: Date.today.strftime('%B'), created_at: Date.today)

      expect(Employee.fetch_partners(emp.id)).to eq([partner.employee_id])
    end

    it 'verifies all previous partners' do
      create_list(:department, 7)
      create_list(:employee, 6)
      emp = Employee.first
      pair = Employee.where.not(department_id: emp.department_id).sample

      dt = Date.today
      grp = LunchGroup.create!(lunch_date: Utils::first_friday(dt), created_at: dt)
      LunchPartner.create!(lunch_group: grp, employee: emp, department_id: emp.department.id, month: dt.strftime('%B'), created_at: dt)
      partner1 =LunchPartner.create!(lunch_group: grp, employee: pair, department_id: pair.department_id, month: dt.strftime('%B'), created_at: dt)

      dt = Date.today - 1.month
      pair = Employee.where.not(department_id: emp.department_id).sample
      grp = LunchGroup.create!(lunch_date: Utils::first_friday(dt), created_at: dt)
      LunchPartner.create!(lunch_group: grp, employee: emp, department_id: emp.department.id, month: dt.strftime('%B'), created_at: dt)
      partner2 = LunchPartner.create!(lunch_group: grp, employee: pair, department_id: pair.department_id, month: dt.strftime('%B'), created_at: dt)

      expect(Employee.fetch_previous_partners(emp.id)).to match_array([partner1.employee_id, partner2.employee_id ])
    end
  end
end