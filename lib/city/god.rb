require 'celluloid'
require 'virtus'
require 'city/person'

module City
  class God
    include Virtus
    include Celluloid

    attribute :people, Array[Person]

    def run
      add_person if people.empty?
      people.each { |person| person.action }
      after(1) {
        run
      }
    end

    def add_person
      people << Person.new(
        :name => "man-#{people.size}",
        :position => Position.new(
          :latitude => rand(10),
          :longitude => rand(10)
        )
      )
    end

  end
end
