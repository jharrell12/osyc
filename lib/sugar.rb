class Sugar
  # add my own methods to standard classes
end

class Array
  def join2(join_str, final_join_str)
    if self.size > 2
      [(self[0,self.size-1].join(join_str)),(self[self.size-1])].join((join_str + final_join_str).gsub(/  /, ' '))
    else
      self.join(final_join_str)
    end
  end

  def compact_str
    self.collect{|s| s.to_s.strip.empty? ? nil : s.to_s.strip}.compact.uniq
  end
end


class String
  def wildcard(front = false, back = true)
    s = front ? ('%' + self.strip) : self.strip
    s << '%' if back
    return s
  end

  def is_valid_email_address?
    !!(self =~/^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/)
  end 

  def mixed_case
    self.dup.mixed_case!
  end

  def mixed_case!
    self.squeeze!(' ')
    self.strip!
    return nil if self.size == 0
    if !(self =~ /[A-Z].*[a-z]/)
      self.downcase!
      self.gsub!(/\b([a-z])/) { $1.capitalize }
      self.gsub!(/\'S/, "'s")
      self.gsub!(/ Ii$/, " II")
      self.gsub!(/ Iii$/, " III")
      self.gsub!(/ Iv$/, " IV")
    end
    self
  end 

  def human_size
    self.to_i.human_size
  end

  def commify
    (s=self.to_s;x=s.length;s).rjust(x+(3-(x%3))).gsub(/(\d)(?=\d{3}+(\.\d*)?$)/, '\1,').strip
  end
  
  def self.checkmark
     "\u2713"
  end

  # https://en.wikipedia.org/wiki/Wikipedia:Non-breaking_hyphen
  def self.non_breaking_hyphen
    "\u2011"
  end

  def to_non_breaking_hyphens
    gsub(/-/, "\u2011")
  end

  def to_std_hyphens
    gsub(/\u2011/, '-')
  end

  def to_nbsp
    gsub(/ /, "&nbsp;")
  end

  def to_utfnb
    gsub(/ /, "\u00A0")
  end

  def to_nb
    gsub(/ /, "\u00A0").gsub(/-/, "\u2011")
  end

  def to_sha256
    Digest::SHA256.hexdigest(self)
  end

  def bytesize_truncate!(max_bytesize = 255)
    str = self[0, max_bytesize]
    str = str[0..-2] until str.bytesize <= max_bytesize
    return str
  end

  def is_integer?
    !!(self =~ /\A\d+\z/)
  end
end


class Integer
  def self.do_human_size(i)
    case
      when i < 1.kilobyte then '%d Bytes' % i
      when i < 1.megabyte then '%.1f KB'  % (i / 1.0.kilobyte)
      when i < 1.gigabyte then '%.1f MB'  % (i / 1.0.megabyte)
      when i < 1.terabyte then '%.1f GB'  % (i / 1.0.gigabyte)
      else                     '%.1f TB'  % (i / 1.0.terabyte)
    end.sub('.0', '').to_utfnb
  rescue
      i.to_s
  end

  def human_size
    Integer.do_human_size(self)
  end

  def commify
    self.to_s.commify
  end
end


class NilClass
  def to_non_breaking_hyphens; nil; end
  def to_std_hyphens; nil; end
  def mixed_case; nil; end
  def mixed_case!; nil; end
  def size; 0; end
  def empty?; true; end

  def id()
    raise(ArgumentError, "You have a nil where you didn't expect it: nil.id")
  end  
end