class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string :name
      t.datetime :delivered_at

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
