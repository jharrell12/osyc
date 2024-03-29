module TimestampStrings
  extend ActiveSupport::Concern

  def created_at_str
    self.created_at.nil? ? nil.to_s : self.created_at.to_date.to_s.to_non_breaking_hyphens
  end

  def created_at_timestamp_str
    self.created_at.nil? ? nil.to_s : self.created_at.to_s(:db).to_non_breaking_hyphens.to_utfnb
  end

  def updated_at_str
    self.updated_at.nil? ? nil.to_s : self.updated_at.to_date.to_s.to_non_breaking_hyphens
  end

end
