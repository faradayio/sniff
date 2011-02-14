gem 'falls_back_on', :path => ENV['LOCAL_FALLS_BACK_ON'] if ENV['LOCAL_FALLS_BACK_ON']
gem 'cohort_scope', :path => ENV['LOCAL_COHORT_SCOPE'] if ENV['LOCAL_COHORT_SCOPE']
gem 'data_miner', :path => ENV['LOCAL_DATA_MINER'] if ENV['LOCAL_DATA_MINER']
gem 'leap', :path => ENV['LOCAL_LEAP'] if ENV['LOCAL_LEAP']
gem 'earth', :path => ENV['LOCAL_EARTH'] if ENV['LOCAL_EARTH']
# To use local gems, see README.markdown under the Local Gems heading.

source :rubygems

gemspec :path => File.dirname(__FILE__) 
path File.join(File.dirname(__FILE__), 'lib')

gem 'roo', '~> 1.9.3'

if RUBY_VERSION =~ /^1\.8/
  gem 'fastercsv'
end
