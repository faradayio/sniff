# sniff
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

### Rake Task
Sniff comes with a rake task that will load a console with a given earth domain:

    require 'sniff'
    require 'sniff/rake_task'
    Sniff::RakeTask.new do |t|
      t.earth_domains = [:air, :locality]
    end

At the command prompt, do:

    > rake console
    irb > ZipCode.first
    #=> <ZipCode id="...>

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
