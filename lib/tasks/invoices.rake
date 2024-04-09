namespace :invoices do 
  desc "Create Invoices for Current Year"
  task create: :environment do 
    year = Date.today.year
    Membership.active.each do |member|
      
    end
  end
end
