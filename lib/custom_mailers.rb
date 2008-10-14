=begin
    @@smtp_settings = {
      :address        => "localhost",
      :port           => 25,
      :domain         => 'localhost.localdomain',
      :user_name      => nil,
      :password       => nil,
      :authentication => nil
    }
=end


module CustomMailers
  # Method called when this module is included, the ActiveMailer::Base is passed in as the parameter
  def self.included(base) 
    # Adds the methods in module ClassMethods to ActiveMailer::Base
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def deliver_from(settings={:address => "localhost", :port => 25, :domain => "localhost.localdomain"})
      # class_inheritable_accessor = a variable which transmits a default value across
      # the inheritance tree, but that allows each subclass to privately modify it
      self.class_inheritable_accessor :smtp_settings
      self.smtp_settings = settings

      yield self

    end
    
  end
end


ActionMailer::Base.send :include, CustomMailers