desc "Listens for changes to the solutions directory"
task :listen => :environment do
  root = "#{Rails.root}/solutions"

  puts "Watching #{root} for changes ..."

  Listen.to(root) do |m, a, r|
    (m + a + r).each do |file|
      print "Checking `#{file}` ... "
      s = Solution.for_file(file)
      s.compute!
      puts s.state
      s.notify
    end
  end
end