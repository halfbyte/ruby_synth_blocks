require 'synth_blocks/core/state_variable_filter'
require 'synth_blocks/mod/envelope'

module SynthBlocks
  module Drum
    ##
    # Simple Hihat generator
    # Nois > Filter > Amp
    class Hihat < SynthBlocks::Core::Sound
      ##
      # === parameters
      # flt_frequency - center frequency of the bandpass filter
      #
      # flt_Q - Q (resonance) value of the bandpass filter
      #
      # amp_attack - attack time in seconds
      #
      # amp_decay - decay time in seconds
      #
      def initialize(sfreq, preset = {})
        super(sfreq, mode: :polyphonic)
        @filter = SynthBlocks::Core::StateVariableFilter.new(sfreq)
        @preset = {
          flt_frequency: 10000,
          flt_Q: 2,
          amp_attack: 0.001,
          amp_decay: 0.1,
        }.merge(preset)
        @amp_env = SynthBlocks::Mod::Envelope.new(@preset[:amp_attack], @preset[:amp_decay])
      end

      def duration(_) # :nodoc:
        @preset[:amp_attack] + @preset[:amp_decay]
      end

      # Run the generator (offset is given in samples)
      def run(offset)
        # time in seconds
        t = time(offset)
        events = active_events(t)
        if events.empty?
          0.0
        else
          event = events[events.keys.last]
          # lfo_out = (@lfo.run(@preset[:lfo_frequency], waveform: @preset[:lfo_waveform]) + 1) / 8 + 0.5
          local_started = t - event[:started]
          noise_out = rand * 2.0 - 1.0
          noise_out = @filter.run(noise_out, @preset[:flt_frequency], @preset[:flt_Q], type: :bandpass)
          0.3 * noise_out * @amp_env.run(local_started)
        end
      end
    end
  end
end