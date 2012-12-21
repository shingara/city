require 'virtus'
module City
  class Position
    include Virtus

    attribute :latitude, Float
    attribute :longitude, Float

    def change(count)
      self.latitude += random_move(count)
      self.longitude += random_move(count)
    end

    def to_s
      "#{latitude}/#{longitude}"
    end

    def random_move(count)
      mov = rand(count * 100) / 100
      rand(1) == 0 ? -mov : mov
    end

  end
end
