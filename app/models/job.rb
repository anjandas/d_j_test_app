class Job < ActiveRecord::Base
  validates :name, :presence => true
  def perform_job
     sleep 10 # placeholder for performing the job
     update_attribute(:delivered_at, Time.now)
  end
end
