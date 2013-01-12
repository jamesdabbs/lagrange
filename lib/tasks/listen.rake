desc "Listens for changes to the solutions directory"
task :listen => :environment do
  Listen.to("#{Rails.root}/solutions") do |m, a, r|
    (m + a + r).each do |file|
      Solution.for_file(file).compute!
    end
  end
end