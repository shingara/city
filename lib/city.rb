module City
  def self.logger
    @@logger ||= Logger.new($stdout)
  end
end

require 'city/position'
require 'city/person'
require 'city/god'
