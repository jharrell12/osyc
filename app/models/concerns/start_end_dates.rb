module StartEndDates
  extend ActiveSupport::Concern

  included do
    attribute :start_date, default: -> { Date.today }
    validates_presence_of :start_date
    validates :end_date, comparison: { greater_than_or_equal_to: :start_date }, allow_blank: true
    scope :current,         -> { where("(end_date is null) OR DATE(end_date) >= DATE('now')") }
  end

  def current? = end_date.nil? || end_date > Date.today  

end