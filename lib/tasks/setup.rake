require 'open-uri'

desc "Sets up user configuration and populates the Problems list"
task :setup => :environment do

  puts "== Configuration ====="
  puts "What directory will contain your solutions?"
  solution_path = prompt "#{Rails.root}/solutions"

  puts %{
    Lagrange attempts to provide links to open solutions in the editor
    of your choice. This may require some configuration (e.g. `subl-handler`
    for Sublime Text 2).
  }.squish
  puts  "\nPlease enter your preferred editor protocol (e.g. subl, txmt, mvim):"
  editor = prompt "subl"

  conf = { "editor" => editor.empty? ? "subl" : editor }

  puts "Storing configuration ...\n"
  File.open("#{Rails.root}/config/user.yml", 'w') do |f|
    YAML.dump({
      "editor"        => editor,
      "solution_path" => solution_path
    }, f)
  end

  puts "\n== Database =========="
  Rake::Task["db:setup"].invoke

  puts "\n== Problems =========="
  print "Fetching problems from Project Euler ... "
  count = open('http://projecteuler.net/show=all').read.
    scan( /Problem \d+/ ).
    map { |s| s.split(' ').last.to_i }.
    max
  puts "found #{count}"

  failed = []
  1.upto(count) do |n|
    Rake::Task.show_progress(n, count)
    p = Problem.find(n) rescue Problem.create!
    p.fetch rescue (failed << p.id)
  end

  unless failed.empty?
    puts "Some problems failed to fetch. You may need to manually re-fetch them."
    puts "Failed problem ids: #{failed.join(', ')}"
  end

  puts "\n== Solutions ======"
  Rake::Task["solutions:check"].invoke

  puts "\n\nSetup complete. Run `foreman start` to begin."
end

def prompt(default)
  print "Enter for `#{default}` > "
  value = STDIN.gets.strip
  puts ""
  value.empty? ? default : value
end

module Rake
  class Task
    def self.show_progress(done, total)
      digits   = total.to_s.length
      used     = 2 * digits + 7
      width    = `/usr/bin/env tput cols`.to_i - used
      count    = "#{done.to_s.rjust(digits)} of #{total}"
      progress = ((done / total.to_f) * width).to_i
      fill     = ("=" * progress).ljust(width)
      print "\r#{count} [#{fill}]"
      puts  "" if done == total
    end
  end
end