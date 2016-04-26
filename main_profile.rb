require('./config/bootstrap.rb')

StackProf.run(mode: :cpu, out: 'tmp/stackprof.dump') do
  source = './data/source.txt'
  File.open(source) do |f|
    data = f.read

    conference = Conference.new(data)

    conference.schedule_tracks_with_talks

    conference.print_scheduled_tracks
  end
end
