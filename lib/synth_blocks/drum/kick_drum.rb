require 'synth_blocks/core/sound'
require 'synth_blocks/core/oscillator'
require 'synth_blocks/mod/envelope'

module SynthBlocks
  module Drum
    ##
    # A simple kick drum generator
    class KickDrum < SynthBlocks::Core::Sound

      ##
      # === Structure
      # Pitch Env > Sine wave OSC >
      #
      # === parameter:
      # - pitch_attack, pitch_decay - Pitch envelope params in s
      # - amp_attack, amp_decay - Amp envelope params in s
      # - base_frequency - base frequency in Hz
      # - pitch_mod - frequency modulation amount in Hz
      def initialize(sfreq, preset = {})
        super(sfreq, mode: :polyphonic)
        @preset = {
          pitch_attack: 0.001,
          pitch_decay: 0.02,
          amp_attack: 0.001,
          amp_decay: 0.15,
          base_frequency: 55,
          pitch_mod: 200
        }.merge(preset)
        @oscillator = SynthBlocks::Core::Oscillator.new(@sampling_frequency)
        @pitch_env = SynthBlocks::Mod::Envelope.new(@preset[:pitch_attack], @preset[:pitch_decay])
        @amp_env = SynthBlocks::Mod::Envelope.new(@preset[:amp_attack], @preset[:amp_decay])
      end

      def duration(_) # :nodoc:
        @preset[:amp_attack] + @preset[:amp_decay]
      end
      ##
      # Run generator
      def run(offset)
        t = time(offset)
        events = active_events(t)
        if events.empty?
          0.0
        else
          event = events[events.keys.last]
          local_started = t - event[:started]
          osc_out = @oscillator.run(@preset[:base_frequency].to_f + @pitch_env.run(local_started) * @preset[:pitch_mod].to_f, waveform: :sine)
          osc_out = osc_out * 1.0 * @amp_env.run(local_started)
        end
      end
    end
  end
end