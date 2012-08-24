module Refinery
  module Jobs
    class Job < Refinery::Core::BaseModel
      self.table_name = 'refinery_jobs'      
    
      acts_as_indexed :fields => [:title, :address, :degree, :experience, :description]

      validates :title, :presence => true, :uniqueness => true
              
    end
  end
end
