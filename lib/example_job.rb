class ExampleJob < Struct.new(:job_id)
  def perform
    job = Job.find(job_id)
    job.perform_job
  end
end
