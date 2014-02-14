class BeermappingAPI
    def self.places_in(city)
        Place
        city=city.downcase
        Rails.cache.write(city, fetch_places_in(city), expires_in: 60.minutes) if not Rails.cache.exist?(city)
        return Rails.cache.read(city)
    end
    def self.key
        return "492678f9f5632828f8daa0c93e28f071"
    end
    def self.place_with_id(id)
        Place
        Rails.cache.write("place_#{id}", fetch_place_with_id(id), expires_in: 60.minutes) if not Rails.cache.exist?("place_#{id}")
        return Rails.cache.read("place_#{id}")
    end

    private

    def self.fetch_place_with_id(id)
        url = "http://beermapping.com/webservice/locquery/#{key}/"
        response = HTTParty.get "#{url}#{id}"
        place = response.parsed_response["bmp_locations"]["location"]
        return nil if place.is_a?(Hash) and place['id'].nil?
        return Place.new(place)
    end

    def self.fetch_places_in(city)
        url = "http://beermapping.com/webservice/loccity/#{key}/"

        response = HTTParty.get "#{url}#{city.gsub(' ', '%20')}"
        places = response.parsed_response["bmp_locations"]["location"]

        return [] if places.is_a?(Hash) and places['id'].nil?

        places = [places] if places.is_a?(Hash)
        return places.inject([]) do | set, place |
          set << Place.new(place)
        end
    end
end