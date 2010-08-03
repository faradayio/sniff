# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sniff}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Derek Kastner"]
  s.date = %q{2010-08-03}
  s.description = %q{Provides data environment for emitter gems}
  s.email = %q{derek.kastner@brighterplanet.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "lib/sniff.rb",
     "lib/sniff/database.rb",
     "lib/sniff/emitter.rb",
     "lib/sniff/tasks.rb",
     "lib/test_support/cucumber/step_definitions/carbon_steps.rb",
     "lib/test_support/cucumber/step_definitions/committee_steps.rb",
     "lib/test_support/cucumber/support/values.rb",
     "lib/test_support/db/fixtures/census_divisions.csv",
     "lib/test_support/db/fixtures/census_regions.csv",
     "lib/test_support/db/fixtures/climate_divisions.csv",
     "lib/test_support/db/fixtures/countries.csv",
     "lib/test_support/db/fixtures/egrid_regions.csv",
     "lib/test_support/db/fixtures/egrid_subregions.csv",
     "lib/test_support/db/fixtures/genders.csv",
     "lib/test_support/db/fixtures/petroleum_administration_for_defense_districts.csv",
     "lib/test_support/db/fixtures/states.csv",
     "lib/test_support/db/fixtures/urbanities.csv",
     "lib/test_support/db/fixtures/zip_codes.csv"
  ]
  s.homepage = %q{http://github.com/brighterplanet/sniff}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Test support for Brighter Planet carbon gems}
  s.test_files = [
    "spec/lib/sniff/database_spec.rb",
     "spec/spec_helper.rb",
     "lib/test_support/cucumber/step_definitions/carbon_steps.rb",
     "lib/test_support/cucumber/step_definitions/committee_steps.rb",
     "lib/test_support/cucumber/support/values.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, ["= 3.0.0.beta4"])
      s.add_runtime_dependency(%q<activesupport>, ["= 3.0.0.beta4"])
      s.add_runtime_dependency(%q<sqlite3-ruby>, ["= 1.3.0"])
      s.add_runtime_dependency(%q<common_name>, ["= 0.1.5"])
      s.add_runtime_dependency(%q<earth>, [">= 0.0.14"])
      s.add_runtime_dependency(%q<timeframe>, ["= 0.0.8"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["= 2.0.0.beta.17"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<fast_timestamp>, ["= 0.0.4"])
    else
      s.add_dependency(%q<activerecord>, ["= 3.0.0.beta4"])
      s.add_dependency(%q<activesupport>, ["= 3.0.0.beta4"])
      s.add_dependency(%q<sqlite3-ruby>, ["= 1.3.0"])
      s.add_dependency(%q<common_name>, ["= 0.1.5"])
      s.add_dependency(%q<earth>, [">= 0.0.14"])
      s.add_dependency(%q<timeframe>, ["= 0.0.8"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["= 2.0.0.beta.17"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<fast_timestamp>, ["= 0.0.4"])
    end
  else
    s.add_dependency(%q<activerecord>, ["= 3.0.0.beta4"])
    s.add_dependency(%q<activesupport>, ["= 3.0.0.beta4"])
    s.add_dependency(%q<sqlite3-ruby>, ["= 1.3.0"])
    s.add_dependency(%q<common_name>, ["= 0.1.5"])
    s.add_dependency(%q<earth>, [">= 0.0.14"])
    s.add_dependency(%q<timeframe>, ["= 0.0.8"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["= 2.0.0.beta.17"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<fast_timestamp>, ["= 0.0.4"])
  end
end

