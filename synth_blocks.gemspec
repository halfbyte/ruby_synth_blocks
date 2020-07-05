require 'rake'

Gem::Specification.new do |s|
  s.name        = 'synth_blocks'
  s.version     = '1.0.2'
  s.licenses    = ['AGPL-3.0-only']
  s.summary     = "Building blocks for making music in pure ruby"
  s.description = "A collection of building blocks for making music in pure ruby"
  s.authors     = ["Jan Krutisch"]
  s.email       = 'jan@krutisch.de'
  s.files       = FileList[
                    'lib/**/*.rb',
                    'README.md',
                    'LICENSE',
                  ].to_a
  s.homepage    = 'https://rubysynth.fun'
  s.metadata    = { "source_code_uri" => "https://github.com/halfbyte/synth_blocks" }

  s.add_development_dependency 'minitest', '~> 5.14'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_dependency 'wavefile', '~> 1.1'
end