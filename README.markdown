# sniff
Testing environment for Brighter Planet Climate Middleware emission calculation gems.

This gem provides:
 * Sample climate data, representative of data found on http://data.brighterplanet.com
 * References to gems needed by each emitter gem  

# Usage
Within an emitter gem's test setup, you can:
    require 'sniff'
    
    Sniff::Database.init '/path/to/emitter_project'

# How to contribute
Typical contributions will include updates to test data.

1. Fork the project.
1. Make your feature addition or bug fix.
1. Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
1. Send me a pull request. Bonus points for topic branches.

# Local Gems
Sniff depends on several gems, some of which are developed by Brighter Planet.  You can tell Sniff or any of the carbon gems to use your local repos in lieu of installed rubygems through the following steps:


Paste the following functions into your ~/.bash_profile
    function mod_devgem() {
      var="LOCAL_`echo $2 | tr 'a-z' 'A-Z'`"
      
      if [ "$1" == "disable" ]
      then
        echo "unset $var"
        `unset $var`
      else
        dir=${3:-"~/$2"}
        echo "export $var=$dir"
        `export $var=$dir`
      fi
    }
    
    function devgems () {
      # Usage: devgems [enable|disable] [gemname]
      cmd=${1:-"enable"}
      if [ -z $2 ]
      then
        mod_devgem $cmd characterizable
        mod_devgem $cmd cohort_scope
        mod_devgem $cmd falls_back_on
        mod_devgem $cmd leap
        mod_devgem $cmd loose_tight_dictionary
        mod_devgem $cmd sniff
        mod_devgem $cmd data_miner
      else
        mod_devgem $cmd $2
      fi
    }

To enable all local gems, run `devgems enable`
To turn off devgems, run `devgems disable`
To turn off a specific gem, run `devgems disable leap`
To turn on a specific gem, run `devgems enable leap`

Typical development process:
    cd ~
    git clone http://github.com/rossmeissl/leap.git
    cd leap
    <do some development on leap>
    cd ~/sniff
    devgems enable leap
    rake gemspec
    rm -f Gemfile.lock
    bundle install
    <run tests, e.g. `spec spec`>
