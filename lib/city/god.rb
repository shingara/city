require 'celluloid'
require 'virtus'

module City
  class God
    include Virtus
    include Celluloid
    include Celluloid::Logger
     include Celluloid::Notifications

    attribute :people, Array[City::Person]

    trap_exit :actor_died

    def run
      @subscriber ||= subscribe(:birth, :add_person)
      add_person if people.empty?
      people.each { |person| person.action }
      after(1) {
        info("new turn")
        run
      }
    end

    def add_person(parent=nil)
      info "new person created"
      self.people << Person.new(
        :name => "man-#{people.size}",
        :position => Position.new(
          :latitude => rand(10),
          :longitude => rand(10)
        )
      )
    end

    def stop
      people.each{ |person| person.terminate }
      terminate
    end

    def actor_died(actor, reason)
      info "Oh no! #{actor.inspect} has died because of a #{reason.class}"
    end

  end
end
