require 'bundler/setup'
Bundler.require

Dir['./app/**/*.rb'].each { |f| require f }

source = './data/source.txt'
File.open(source) do |f|
  data = f.read

  conference = Conference.new(data)

  conference.schedule_tracks_with_talks

  conference.render_scheduled_tracks

  unless conference.invalid_talks.empty?
    puts '-' * 50
    puts conference.invalid_talks
    puts '-' * 50
    puts
  end

  conference.schedule_result.each_with_index do |schedule, i|
    puts "Track #{i + 1}"
    puts schedule
    puts
  end
end
