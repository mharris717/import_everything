# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "import_everything"
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mike Harris"]
  s.date = "2013-01-10"
  s.description = "import everything"
  s.email = "mharris717@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "import_everything.gemspec",
    "lib/import_everything.rb",
    "lib/import_everything/determine_type.rb",
    "lib/import_everything/ext.rb",
    "lib/import_everything/parser/line_parser.rb",
    "lib/import_everything/parser/module_methods.rb",
    "lib/import_everything/parser/parser.rb",
    "lib/import_everything/parsers/csv_parser.rb",
    "lib/import_everything/parsers/sql_parser.rb",
    "lib/import_everything/parsers/sqlite_parser.rb",
    "lib/import_everything/parsers/table_parser.rb",
    "lib/import_everything/parsers/xml_parser.rb",
    "lib/import_everything/parsers/yaml_parser.rb",
    "lib/import_everything/preview.rb",
    "spec/data/bets.html",
    "spec/data/database.yml",
    "spec/data/howard.html",
    "spec/data/players.csv",
    "spec/data/players.sql",
    "spec/data/players.xml",
    "spec/helpers/test_db.rb",
    "spec/import_everything_spec.rb",
    "spec/junk.rb",
    "spec/parsers/csv_parser_spec.rb",
    "spec/parsers/sql_parser_spec.rb",
    "spec/parsers/sqlite_parser_spec.rb",
    "spec/parsers/xml_parser_spec.rb",
    "spec/parsers/yaml_parser_spec.rb",
    "spec/preview_spec.rb",
    "spec/spec_helper.rb",
    "vol/filename_meth.rb",
    "vol/test_db_test.rb",
    "vol/web_test.rb",
    "yard_ext.rb"
  ]
  s.homepage = "http://github.com/mharris717/import_everything"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "import everything"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mharris_ext>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_runtime_dependency(%q<hpricot>, [">= 0"])
      s.add_runtime_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.2"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.4"])
    else
      s.add_dependency(%q<mharris_ext>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<hpricot>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.2"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
    end
  else
    s.add_dependency(%q<mharris_ext>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<hpricot>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.2"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
  end
end

