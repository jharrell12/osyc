class ReportsController < ApplicationController
  layout 'reports'

  def roster
    @memberships = Membership.active.order(Arel.sql("(select min(last_name) from people where people.membership_id = memberships.id)"))
  end

  def balance_due
    @invoices = Invoice.balance_due
  end
end
