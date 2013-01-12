namespace :solutions do
  
  desc "Re-computes and checks all existing Solutions"
  task :check => :environment do
    ss    = Solution.attempted
    count = ss.length
    puts "Checking solutions ... found #{count}" if count
    ss.each_with_index do |s,i|
      s.compute!
      Rake::Task.show_progress(i+1, count)
    end
  end

end