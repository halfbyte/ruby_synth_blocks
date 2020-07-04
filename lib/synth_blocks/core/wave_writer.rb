module SynthBlocks
  module Core
    ##
    # Writes Floating point data to a wavefile using the wave file gem
    if RUBY_ENGINE == 'opal'
      class WaveWriter
        def self.write_if_name_given(samples)
          raise "Not Implemented in OPAL"
        end
      end
    else
      require 'wavefile'
      class WaveWriter
        ##
        # Static method to write to file given as first argument IF given
        def self.write_if_name_given(samples)
          if (ARGV[0])
            WaveWriter.new(ARGV[0]).write(samples)
          end
        end

        def initialize(filename)
          @filename = filename
        end

        def write(float_data)
          buffer = WaveFile::Buffer.new(float_data, WaveFile::Format.new(:mono, :float, 44100))
          WaveFile::Writer.new(@filename, WaveFile::Format.new(:mono, :pcm_16, 44100)) do |writer|
             writer.write(buffer)
          end
        end
      end
    end
  end
end