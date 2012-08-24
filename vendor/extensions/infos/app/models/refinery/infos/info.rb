module Refinery
  module Infos
    class Info < Refinery::Core::BaseModel
      default_scope :order => 'created_at DESC'
      self.table_name = 'refinery_infos'      
    
      acts_as_indexed :fields => [:title, :source, :content]

      validates :title, :presence => true, :uniqueness => true
      
      scope :recent, where("created_at > ?", Time.now.at_beginning_of_year)
    end
  end
end
