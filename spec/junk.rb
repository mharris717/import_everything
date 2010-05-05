class MyProxyFoo
  attr_accessor :obj_block
  include FromHash
  fattr(:obj) { obj_block[] }
  def method_missing(sym,*args,&b)
   # raise "sending #{args.inspect}"
    obj.send(sym,*args,&b)
  end
end

def try_all(*args)
  args.flatten.each do |arg|
    begin
      yield(arg)
      puts "#{arg} worked"
      return
    rescue(RuntimeError)
      puts "runtimeerror"
    rescue
      puts "generic error"
    end
  end
  raise "none worked"
end
