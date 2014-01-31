# Copyright:: Copyright 2014 Trimble Navigation Ltd.
# License:: The MIT License (MIT)
# Original Author:: Thomas Thomassen


module TestUp
 class Settings

  # @param [String] settings_id
  def initialize(settings_id, defaults = {})
    @settings_id = settings_id
    @defaults = defaults
    # Cache data so we don't have to query the registry or plist all the time.
    # Some of these settings are queried by context menu handlers.
    @data = Hash.new { |hash, key|
      Sketchup.read_default(@settings_id, key.to_s, @defaults[key])
    }
  end

  def [](key)
    @data[key] || @defaults[key]
  end

  def []=(key, value)
    Sketchup.write_default(@settings_id, key.to_s, value)
    @data[key] = value
  end

  def inspect
    to_s
  end

 end # class
end # module TestUp
