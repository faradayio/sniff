# you will have to temporarily switch it from a dev to a runtime dependency
gem 'emitter', :path => ENV['LOCAL_EMITTER'] if ENV['LOCAL_EMITTER']
gem 'falls_back_on', :path => ENV['LOCAL_FALLS_BACK_ON'] if ENV['LOCAL_FALLS_BACK_ON']
gem 'cohort_scope', :path => ENV['LOCAL_COHORT_SCOPE'] if ENV['LOCAL_COHORT_SCOPE']
gem 'data_miner', :path => ENV['LOCAL_DATA_MINER'] if ENV['LOCAL_DATA_MINER']
gem 'leap', :path => ENV['LOCAL_LEAP'] if ENV['LOCAL_LEAP']
gem 'earth', :path => ENV['LOCAL_EARTH'] if ENV['LOCAL_EARTH']

source :rubygems

gemspec :path => '.'

if RUBY_VERSION < '1.9'
  gem 'fastercsv'
end
