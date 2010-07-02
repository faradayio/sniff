Gem::Specification.new do |s|
  s.name = 'sniff'
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Derek Kastner"]
  s.date = '2010-04-30'
  s.summary = %Q{Testing environment for carbon.brighterplanet.com.}
  s.description = %Q{Test data and supporting classes for carbon.brighterplanet.com gems.}
  s.email = "derek.kastner@brighterplanet.com"
  s.homepage = "http://github.com/brighterplanet/sniff"
  s.extra_rdoc_files = [
    "MIT-LICENSE.txt",
  ]
  s.files = Dir.glob('lib/**/*') 

  s.add_runtime_dependency 'activerecord', '3.0.0.beta4'
  s.add_runtime_dependency 'validates_decency_of', '>=1.5.1'
  s.add_runtime_dependency 'sqlite3-ruby'
  s.add_development_dependency('cucumber')
  s.add_development_dependency('jeweler')
end
