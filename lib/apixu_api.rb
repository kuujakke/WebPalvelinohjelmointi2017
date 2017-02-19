class ApixuApi

  def self.weather_in(city)
    Rails.cache.fetch(city + "-weather", :expires_in => 1.minute, race_condition_ttl:10) { fetch_weather_in(city)}
  end

  def self.condition_in(city)
    weather = weather_in(city)
    weather["current"]["condition"]["icon"]
  end

  def self.temperature_in(city)
    weather = weather_in(city)
    temperature = weather["current"]["temp_c"]
  end

  def self.wind_in(city)
    weather = weather_in(city)
    speed = weather["current"]["wind_kph"]
    direction = weather["current"]["wind_dir"]
    speed = (speed / 3600 * 1000).round(2)
    "#{speed} m/sec, direction #{direction}"
  end

  private
  def self.fetch_weather_in(city)
    city = city.downcase
    client = Apixu::Client.new "#{key}"
    weather = client.current(city)
    return [] if weather.is_a?(Hash) and weather['location'].nil?
    weather = [weather] if weather.is_a?(Hash)
    weather.first
  end

  def self.key
    raise "APIXUKEY env variable not defined" if ENV['APIXUKEY'].nil?
    ENV['APIXUKEY']
  end
end