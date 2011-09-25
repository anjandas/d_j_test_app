class JobsController < ApplicationController
  def perform_inline
    job = Job.find(params[:id])
    job.perform_job
    flash[:notice] = "Performed #{job.name} job inline"
    redirect_to jobs_url
  end
  
  def perform_old_way
    job = Job.find(params[:id])
    job.delay(:priority => 5).perform_job
    flash[:notice] = "#{job.name} Job is being performed with normal importance using priority of 5. Execute \"rake jobs:work\" to start normal importance worker"
    redirect_to jobs_url
  end
  
  def perform_as_low_importance_with_delay
    job = Job.find(params[:id])
    job.delay(:importance => "low").perform_job
    flash[:notice] = "Low Importance Job #{job.name} is being Performed using delay(). Execute \"rake jobs:low_importance_work\" to start low importance worker"
    redirect_to jobs_url
  end
  
  def perform_as_normal_importance_with_delay
    job = Job.find(params[:id])
    job.delay(:importance => "normal").perform_job
    flash[:notice] = "Normal Importance Job #{job.name} is being Performed using delay(). Execute \"rake jobs:work\" to start normal importance worker"
    redirect_to jobs_url
  end
  
  def perform_as_high_importance_with_delay
    job = Job.find(params[:id])
    job.delay(:importance => "high").perform_job
    flash[:notice] = "High Importance Job #{job.name} is being Performed using delay(). Execute \"rake jobs:high_importance_work\" to start high importance worker"
    redirect_to jobs_url
  end

  def perform_examplejob_with_normal_importance
    Delayed::Job.enqueue(ExampleJob.new(params[:id]))
    flash[:notice] = "ExampleJob is being performed with normal importance using enqueue(). Execute \"rake jobs:normal_importance_work\" to start normal importance worker"
    redirect_to jobs_url
  end
  
  def perform_examplejob_with_high_importance
    Delayed::HighImportanceJob.enqueue(ExampleJob.new(params[:id]))
    flash[:notice] = "ExampleJob is being performed with high importance using enqueue(). Execute \"rake jobs:high_importance_work\" to start high importance worker"
    redirect_to jobs_url
  end
  
  def perform_examplejob_with_low_importance
    Delayed::LowImportanceJob.enqueue(ExampleJob.new(params[:id]))
    flash[:notice] = "ExampleJob is being performed with low importance using enqueue(). Execute \"rake jobs:low_importance_work\" to start low importance worker"
    redirect_to jobs_url
  end
  
  # GET /jobs
  # GET /jobs.xml
  def index
    @jobs = Job.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.xml
  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.xml
  def new
    @job = Job.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.xml
  def create
    @job = Job.new(params[:job])

    respond_to do |format|
      if @job.save
        format.html { redirect_to(@job, :notice => 'Job was successfully created.') }
        format.xml  { render :xml => @job, :status => :created, :location => @job }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.xml
  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to(@job, :notice => 'Job was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.xml
  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to(jobs_url) }
      format.xml  { head :ok }
    end
  end
end
