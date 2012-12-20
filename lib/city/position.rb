require 'virtus'
module City
  class Position
    include Virtus

    attribute :latitude, Float
    attribute :longitude, Float

    def change(count)
      self.latitude += rand(count)
      self.longitude += rand(count)
    end

    def to_s
      "#{latitude}/#{longitude}"
    end

  end
end
