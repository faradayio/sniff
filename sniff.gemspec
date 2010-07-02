# -*- encoding: utf-8 -*-
cwd = File.dirname(__FILE__)

Gem::Specification.new do |s|
  s.name = %q{sniff}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Derek Kastner"]
  s.date = %q{2010-07-02}
  s.description = %q{Test data and supporting classes for carbon.brighterplanet.com gems.}
  s.email = %q{derek.kastner@brighterplanet.com}
  s.files = Dir.glob(File.join(cwd, 'lib', '**/*.rb')) + 
    Dir.glob(File.join(cwd, 'db', '**/*.rb'))
  s.homepage = %q{http://github.com/brighterplanet/sniff}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Testing environment for carbon.brighterplanet.com.}

  s.add_dependency(%q<activerecord>, ["= 3.0.0.beta4"])
  s.add_dependency(%q<data_miner>, ["= 0.4.43"])
  s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
  s.add_dependency(%q<falls_back_on>, ["= 0.0.0"])
  s.add_dependency(%q<cohort_scope>, ["= 0.0.4"])
  s.add_dependency(%q<leap>, ["= 0.2.4"])
  s.add_development_dependency(%q<jeweler>, [">= 0"])
  s.add_development_dependency(%q<rake>, [">= 0"])
  s.add_development_dependency(%q<rspec>, [">= 0"])
end

