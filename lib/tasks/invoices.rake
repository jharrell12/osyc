namespace :invoices do 
  desc "Clear the invoices table"
  task delete_all: :environment do
    puts Charge.delete_all
    puts Payment.delete_all
    puts Invoice.delete_all
  end

  desc "Create Invoices for Current Year"
  task create: :environment do 
    year = Date.today.year
    annual_dues = 350
    slip_fees   = 250
    Membership.active.each do |member|

      invoice = member.invoices.create
      invoice.charges.create(description: "#{year} Annual Dues", price: annual_dues)
      invoice.charges.create(description: "#{year} Slip Fees", price: slip_fees) if member.has_slip?
      invoice.save!
      invoice.post!
    end
  end
end
