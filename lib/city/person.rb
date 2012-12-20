require 'virtus'
require 'celluloid'

module City
  class Person
    include Virtus
    include Celluloid
    include Celluloid::Logger
    include Celluloid::Notifications

    attribute :id, Integer
    attribute :name, String
    attribute :position, Position
    attribute :turn, Integer, :default => 1

    def move(count)
      position.change(count)
      info("#{self} => move to #{position}")
    end

    def action
      move(4)
      duplicate if turn % 5 == 0
      self.turn += 1
    end

    def duplicate
      info("#{self} => give birth")
      publish(:birth, self.name)
      #info god
      # child = god.add_person
    end

    def to_s
      "Person #{self.name}"
    end
  end
end
