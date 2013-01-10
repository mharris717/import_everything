$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'import_everything'
#require 'spec'
#require 'spec/autorun'

RSpec.configure do |config|
  
end

include ImportEverything

def mit(name,&b)
  it(name,&b) #if name == 'parses values'
end

RSpec::Matchers.define :size do |exp_size|
  match do |arr|
    arr.size == exp_size
  end
  failure_message_for_should do |arr|
    "Array is size #{arr.size}, expected #{exp_size}, array is #{arr.inspect}"
  end
end

def pujols_value_hash
  {'first' => 'Albert', 'last' => 'Pujols', 'age' => 29}
end

def pujols_row_hash
  {:table => 'players', :values => pujols_value_hash}
end

def spec_file(f)
  File.expand_path(File.dirname(__FILE__)) + "/data/#{f}"
end

def mylog(*args)
end