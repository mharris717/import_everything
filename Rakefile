# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "import_everything"
  gem.homepage = "http://github.com/mharris717/import_everything"
  gem.license = "MIT"
  gem.summary = %Q{import everything}
  gem.description = %Q{import everything}
  gem.email = "mharris717@gmail.com"
  gem.authors = ["Mike Harris"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec
task :test => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "import_everything #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end



require 'yard'
YARD::Rake::YardocTask.new do |t|
  #t.files   = ['lib/**/*.rb', OTHER_PATHS]   # optional
  #t.options = ['--any', '--extra', '--opts'] # optional
  t.options = ["--reload"]
end

namespace :doc do
  task :generate do
    puts `yardoc -e yard_ext.rb`
  end
  task :server do
    puts `yard server -e yard_ext.rb --reload`
  end
end


 if false
    require 'pp'
    File.open("test.txt","w") do |f|
      f << "Statement\n"
      PP.pp(statement,f)
      f << "\n\n"
    
      modname = statement[0].source
      mod = register ModuleObject.new(namespace, modname)
      parse_block(statement[1], :namespace => mod)
    
      f << "modname\n"
      PP.pp(modname,f)
      f << "\n\n"
    
      f << "namespace\n"
      PP.pp(namespace,f)
      f << "\n\n"
    
      f << "Statement[0]\n"
      PP.pp(statement[0],f)
      f << "\n\n"
    
      f << "Statement[1]\n"
      PP.pp(statement[1],f)
      f << "\n\n"
    
    
    end
    exit
  end
  