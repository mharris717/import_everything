class Object
  def local_methods
    res = methods - 7.methods - ''.methods - Object.new.methods
    res.sort
  end
end

class String
  def blank?
    strip == ''
  end
  def present?
    !blank?
  end
end

module MethodLogging
  def log_method(name)
    alias_method "unlogged_#{name}", name
    define_method(name) do |*args|
      res = send("unlogged_#{name}",*args)
      puts "#{name} returned #{res.inspect} from #{args.inspect}"
      res
    end
  end
  def def_logging_method(name,&b)
    define_method(name) do |*args|
      res = instance_eval()
    end
  end
end

class Hash
  def self.from_keys_and_values(ks,vs)
    raise "size not equal #{ks.size} #{vs.size}" unless ks.size == vs.size
    ks.zip(vs).inject({}) { |h,a| h.merge(a[0] => a[1]) }
  end
end

class String
  def without_quotes
    if self =~ /^['"].*['"]$/
      self[1..-2]
    else
      self
    end
  end
  def to_num_if
    if self =~ /^\d+$/
      self.to_i
    elsif self =~ /^[\d\.]+$/
      self.to_f
    else
      self
    end
  end
  def fixed_obj
    strip.without_quotes.to_num_if
  end
end

module Enumerable
  def make_last
    h = group_by { |x| !!yield(x) }
    (h[false]||[]) + (h[true]||[])
  end
  def make_first
    h = group_by { |x| !!yield(x) }
    (h[true]||[]) + (h[false]||[])
  end
end

class Hash
  def cleaned_hash_values
    map_value { |v| v.fixed_obj }
  end
end

class Object
  def first_responding(*methods)
    methods.flatten.each { |x| return send(x) if respond_to?(x) }
    #raise "none respond"
    #raise local_methods.inspect
    nil
  end
end