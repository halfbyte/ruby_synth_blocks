# Synth Blocks

Synth blocks is a proper extraction of the synthesizer/sequncer I built for my [Ruby Synth](https://rubysynth.fun) talk an Euruko and RubyConf.by

It is a gem and can be used for writing electronic music in ruby. See [examples](examples/) for more info on how to use this.

## Blocks

The code is divided into 7 sections:

- Core contains things like Oscillators and filters, a base class for all generators as well as a class that uses the wavefile gem to write out sound files
- Mod contains modulators, currently two Envelopes
- Drum and Synth contains Drum and Synthesizer generators respectively
- Fx contains Audio effects such as Reverb, Chorus, Delay, Waveshaper and more
- Mixer contains utilities to build a mixing system
- Sequencer contains a DSL for building songs

The code is super unoptimised, as it is written for learning purposes. This means, for example, that the full song contained in [examples/a_song.rb](examples/a_song.rb) 
takes a couple of hours to render. I'm relatively sure that there are some low hanging fruits for optimisation, especially in the sequencer code that does a lot of
useless lookups on quite large data structures that hold the automation data, but I haven't yet gotten around to take a look at it.

## Opal

Since my presentation runs in a browser I thought it could be fun to try to make this library run in Opal and thus in the browser.

It works but obviously long running code that will block the main thread is not something that makes browsers (and users) happy, but for small demonstrations, it's probably good enough.

There are two modules that do not work:

- GVerb uses prime numbers but Opal does not implement Stdlib::Prime.
- To prevent adding WaveFile as an additional dependency (and because it doesn't make a ton of sense for my usecase), WaveWriter is not functional in Opal.

## Examples

The easiest way to test the example code is to check out the repo and then execute the code directly.

Each example has a line on the bottom:

```ruby
SynthBlocks::Core::WaveWriter.write_if_name_given(out)
```

This will write out a wave file if you run the file with a wav-file as the last argument like so:

```bash
ruby -Ilib examples/waveshaper_demo.rb test.wav
```

## License

All code here is licensed under the AGPL 3.0 license as documented at [LICENSE](LICENSE) unless stated otherwise.
