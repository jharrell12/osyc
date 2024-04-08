module StartEndDates
  extend ActiveSupport::Concern

  included do
    validates_presence_of :start_date
    attribute :start_date, default: -> { Date.today }
    validates :end_date, comparison: { greater_than_or_equal_to: :start_date }, allow_blank: true
    scope :sorted, -> { order(end_date: :asc, label: :asc, start_date: :desc) }
    scope :current,         -> { sorted.where("(end_date is null) OR DATE(end_date) >= DATE('now')") }
  end

  def current? = end_date.nil? || end_date > Date.today  

  def set_end_date(operation)
    if operation == 'destroy'
      self.destroy!
      "#{self.class} was deleted."
    elsif operation == 'reactivate'
      self.update!(end_date: nil)    
      "#{self.class} was reactivated."
    else
      self.update!(end_date: Date.today)   
      "#{self.class} was deactivated."
    end      
  end
end