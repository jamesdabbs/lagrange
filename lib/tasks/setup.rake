require 'open-uri'

desc "Sets up user configuration and populates the Problems list"
task :setup => :environment do

  # -- EDITOR -----
  puts %{
    Lagrange attempts to provide links to open solutions in the editor
    of your choice. This may require some configuration (e.g. `subl-handler`
    for Sublime Text 2).
  }.squish
  puts  "\nPlease enter your preferred editor protocol (e.g. subl, txmt, mvim):"
  print "Enter for `subl` > "
  editor = STDIN.gets.strip

  conf = { "editor" => editor.empty? ? "subl" : editor }

  puts "\nStoring configuration ...\n"
  File.open("#{Rails.root}/config/user.yml", 'w') do |f|
    YAML.dump(conf, f)
  end

  # -- PROBLEMS ---
  print "Fetching problems from Project Euler ... "
  count = open('http://projecteuler.net/show=all').read.
    scan( /Problem \d+/ ).
    map { |s| s.split(' ').last.to_i }.
    max
  puts "found #{count}"

  failed = []
  1.upto(count) do |n|
    print progress(n, count)
    p = Problem.find(n) rescue Problem.create!
    p.fetch rescue (failed << p.id)
  end

  unless failed.empty?
    puts "Some problems failed to fetch. You may need to manually re-fetch them."
    puts "Failed fetches: #{failed.join(', ')}"
  end
  puts "\n\nSetup complete. Run `foreman start` to begin."
end

def progress(done, total)
  digits   = total.to_s.length
  used     = 2 * digits + 7
  width    = `/usr/bin/env tput cols`.to_i - used
  count    = "#{done.to_s.rjust(digits)} of #{total}"
  progress = ((done / total.to_f) * width).to_i
  fill     = ("=" * progress).ljust(width)
  "\r#{count} [#{fill}]"
end