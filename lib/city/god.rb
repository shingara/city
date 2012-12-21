require 'celluloid'
require 'virtus'

module City
  class God
    include Celluloid
    include Celluloid::Logger
    include Celluloid::Notifications

    def initialize(puppet_master)
      # @env = DataMapper::Environment.new

      # env.build(Person, :memory) do
      #   key :id
      #     has 0..1, :position, Position
      # end

      # @env.setup(:memory)
      # @env.finalize
      @puppet_master = puppet_master
      @people = []
    end
    attr_reader :people

    trap_exit :actor_died

    def run
      @subscriber ||= subscribe('birth', :new_birth)
      add_person if people.empty?
      people.each { |person|
        @puppet_master.async.action(person)
      }
      after(1) {
        info("new turn")
        run
      }
    end

    def new_birth(topic, parent)
      add_person(parent)
    end

    def add_person(parent=nil)
      #info "new person created"
      self.people << Person.new(
        :name => "man-#{people.count}",
        :position => Position.new(
          :latitude => rand(10),
          :longitude => rand(10)
        )
      )
      info "total pop : #{people.count}"
    end

    def stop
      @puppet_master.terminate
      terminate
    end

    def actor_died(actor, reason)
      info "Oh no! #{actor.inspect} has died because of a #{reason.class}"
    end

  end
end
