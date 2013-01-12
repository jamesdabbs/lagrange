desc "Listens for changes to the solutions directory"
task :listen => :environment do
  puts "Watching #{User.solution_path} for changes ..."

  Listen.to(User.solution_path) do |m, a, r|
    (m + a + r).each do |file|
      print "Checking `#{file}` ... "
      s = Solution.for_file(file)
      s.compute!
      puts s.state
      s.notify
    end
  end
end