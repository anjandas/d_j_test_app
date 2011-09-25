require 'spec_helper'

describe "jobs/show.html.erb" do
  before(:each) do
    @job = assign(:job, stub_model(Job,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
