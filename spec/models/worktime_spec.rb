require 'spec_helper'

describe Worktime do
  let(:employee) { FactoryGirl.create(:employee) }
  before { @worktime = employee.worktimes.build(checkin:DateTime.civil(2007,12,4,0,0,0,0), checkout:DateTime.civil(2007,12,9,0,0,0,0), 
                                                place_checkin:"suit", place_checkout:"media") }

  subject { @worktime }

  it { should respond_to(:checkin) }
  it { should respond_to(:checkout) }
  it { should respond_to(:place_checkin) }
  it { should respond_to(:place_checkout) }
  it { should respond_to(:employee) }
  it { should respond_to(:employee_id) }
  its(:employee) { should == employee }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to employee_id" do
      expect do
        Worktime.new(employee_id: employee.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when employee_id is not present" do
    before { @worktime.employee_id = nil }
    it { should_not be_valid }
  end
end
