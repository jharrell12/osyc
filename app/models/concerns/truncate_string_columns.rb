#require 'active_support/core_ext/class/attribute'
#require 'active_support/concern'

module TruncateStringColumns
  extend ActiveSupport::Concern

  included do 
    class_attribute :truncation_list
    self.truncation_list = Hash.new 
    before_validation :truncate_string_columns

    class_attribute :strip_list
    self.strip_list = Hash.new 
    before_validation :strip_string_columns
  end

  class_methods do 
    def truncate_strings(*cols)
      self.truncation_list = cols.collect{|c| self.columns_hash[c.to_s]}.collect{|col| [col.name, (col.limit || 255)] if col.type == :string}.compact
    end
    def strip_strings(*cols)
      self.strip_list = cols.collect{|c| self.columns_hash[c.to_s]}.collect{|col| col.name if col.type == :string}.compact
    end
  end

  protected
  def truncate_string_columns
    truncation_list.each do |name, max_bytesize|
      str = self.__send__(name)
      next if !str.kind_of?(String) || str.nil? || str.bytesize <= max_bytesize
      str = str[0, max_bytesize]
      str = str[0..-2] until str.bytesize <= max_bytesize
      self.__send__(:"#{name}=", str)
    end
  end

  def strip_string_columns
    strip_list.each do |name|
      str = self.__send__(name)
      next if !str.kind_of?(String) || str.nil? || !attribute_changed?(name)
      self.__send__(:"#{name}=", str.strip)
    end
  end

end
