class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include TimestampStrings
  include TruncateStringColumns
end
