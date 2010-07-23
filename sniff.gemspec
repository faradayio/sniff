# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sniff}
  s.version = "0.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Derek Kastner"]
  s.date = %q{2010-07-22}
  s.description = %q{# sniff
Development environment for Brighter Planet emitters.

## Background
Brighter Planet's emitters, such as [`flight`](http://github.com/brighterplanet/flight), inhabit a complex production runtime environment backing its [emission estimates web service](http://carbon.brighterplanet.com). Sniff simulates this environment, including representative data, fixtures, and other supporting code, so that developers can test improvements to the emitters before submitting them back to Brighter Planet.

### Caution
The data and other supporting information in the sniff environment is only representative of production data and in many cases is purely fictional, contrived to return predictable results in tests. Emission estimates and other information gleaned from execution within this environment will undoubtedly be--to put it simply--wrong. For real numbers, always use live queries to the [emission estimate web service](http://carbon.brighterplanet.com).

## Usage
Sniff is never used directly but rather as a requirement of a specific emitter. Current production emitters include, for example:

* [Automobile](http://github.com/brighterplanet/automobile)
* [Flight](http://github.com/brighterplanet/flight)
* [Residence](http://github.com/brighterplanet/residence)

For a complete list, see the emission estimate service's [documentation](http://carbon.brighterplanet.com/use).

## The emitter
An emitter is a software model of a real-world emission source, like a flight. Brighter Planet's emitter libraries each comprise a carbon model, an attribute curation policy, a persistence schema, and a summarization strategy.

### Persistence schema
Although the production environment does not persist emitter instances, we nevertheless define emitter schemas to enable ActiveRecord assocations. An emitter's schema is defined in `lib/*emitter_name*/data.rb` within an emitter library. For example, here is [flight's schema](http://github.com/brighterplanet/flight/blob/master/lib/flight/data.rb).

Schema are defined using a DSL provided by the [data_miner](http://github.com/seamusabshere/data_miner) library.

### Attribute curation policy
This defines how an emitter's attributes (initialized and stored with respect to the schema) are curated and decorated into a snapshot for later use by the carbon model. The policy is defined in `lib/*emitter_name*/characterization.rb` within an emitter library. For example, here is [flight's characterization](http://github.com/brighterplanet/flight/blob/master/lib/flight/characterization.rb).

Characterizations are defined using a DSL provided by the [characterizable](http://github.com/seamusabshere/characterizable) library.

### Carbon model
An emission estimate is obtained by giving an emitter's curated characteristics as input to an execution of its carbon model. The model is defined in `lib/*emitter_name*/characterization.rb` within an emitter library. For example, here is [flight's carbon model](http://github.com/brighterplanet/flight/blob/master/lib/flight/carbon_model.rb).

Carbon models are defined using a DSL provided by the [leap](http://github.com/rossmeissl/leap) library.

### Summarization strategy
Summaries are human-friendly descriptions of characterized emitters. The strategy is defined in `lib/*emitter_name*/summarization.rb` within an emitter library. For example, here is [flight's summarization strategy](http://github.com/brighterplanet/flight/blob/master/lib/flight/summarization.rb).

Summarizations are defined using a DSL provided by the [summary_judgement](http://github.com/rossmeissl/summary_judgement) library.

## Collaboration cycle 
Brighter Planet vigorously encourages collaborative improvement of its emitter libraries. Collaboration requires a (free) GitHub account.

### You
1.  Fork the emitter repository on GitHub.
1.  Write a test proving the existing implementation's inadequacy. Ensure that the test fails. Commit the test.
1.  Improve the code until your new test passes and commit your changes.
1.  Push your changes to your GitHub fork.
1.  Submit a pull request to brighterplanet.

### Brighter Planet
1.  Receive a pull request.
1.  Pull changes from forked repository.
1.  Ensure tests pass.
1.  Review changes for scientific accuracy.
1.  Merge changes to master repository and publish.
1.  Direct production environment to use new emitter version.
}
  s.email = %q{derek.kastner@brighterplanet.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "lib/sniff.rb",
     "lib/sniff/database.rb",
     "lib/sniff/emitter.rb",
     "lib/sniff/tasks.rb",
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
     "lib/test_support/db/fixtures/zip_codes.csv",
     "lib/test_support/step_definitions/carbon_steps.rb"
  ]
  s.homepage = %q{http://github.com/brighterplanet/sniff}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Test support for Brighter Planet carbon gems}
  s.test_files = [
    "spec/lib/sniff/database_spec.rb",
     "spec/spec_helper.rb",
     "lib/test_support/step_definitions/carbon_steps.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, ["= 3.0.0.beta4"])
      s.add_runtime_dependency(%q<activesupport>, ["= 3.0.0.beta4"])
      s.add_runtime_dependency(%q<sqlite3-ruby>, ["= 1.3.0"])
      s.add_runtime_dependency(%q<common_name>, ["= 0.1.5"])
      s.add_runtime_dependency(%q<earth>, ["= 0.0.7"])
      s.add_runtime_dependency(%q<timeframe>, ["= 0.0.8"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["= 2.0.0.beta.17"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, ["= 3.0.0.beta4"])
      s.add_dependency(%q<activesupport>, ["= 3.0.0.beta4"])
      s.add_dependency(%q<sqlite3-ruby>, ["= 1.3.0"])
      s.add_dependency(%q<common_name>, ["= 0.1.5"])
      s.add_dependency(%q<earth>, ["= 0.0.7"])
      s.add_dependency(%q<timeframe>, ["= 0.0.8"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["= 2.0.0.beta.17"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, ["= 3.0.0.beta4"])
    s.add_dependency(%q<activesupport>, ["= 3.0.0.beta4"])
    s.add_dependency(%q<sqlite3-ruby>, ["= 1.3.0"])
    s.add_dependency(%q<common_name>, ["= 0.1.5"])
    s.add_dependency(%q<earth>, ["= 0.0.7"])
    s.add_dependency(%q<timeframe>, ["= 0.0.8"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["= 2.0.0.beta.17"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
  end
end

