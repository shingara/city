require 'virtus'
require 'city'
require 'city/position'

module City
  class Person
    include Virtus

    attribute :id, Integer
    attribute :name, String
    attribute :position, Position
    attribute :turn, Integer, :default => 0

    def move(count)
      position.change(count)
      City.logger.info("#{name} => move to #{position}")
    end

    def action
      move(4)
      self.turn += 1
    end
  end
end
