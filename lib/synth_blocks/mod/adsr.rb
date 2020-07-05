module SynthBlocks
  module Mod
    ##
    # Implementation of a linear ADSR envelope generator with a tracking
    # value so that envelope restarts don't click
    class Adsr
      ##
      # attack time in seconds
      attr_accessor :attack

      ##
      # decay time in seconds
      attr_accessor :decay
      ##
      # sustain level (0.0-1.0)
      attr_accessor :sustain

      ##
      # release time in seconds
      attr_accessor :release

      ##
      # Creates new ADSR envelope
      #
      # attack, decay and release are times in seconds (as float)
      #
      # sustain should be between 0 and 1
      def initialize(attack, decay, sustain, release)
        @value = 0
        @start_value = 0
        @attack = attack
        @decay = decay
        @sustain = sustain
        @release = release
      end

      ##
      # run the envelope.
      #
      # if released is given (should be <= t), the envelope will enter the release stage
      # returns the current value between 0 and 1
      def run(t, released)
        attack_decay = attack + decay
        if !released
          if t < 0.0001 # initialize start value (slightly hacky, but works)
            @start_value = @value
            return @start_value
          end
          if t <= attack # attack
            return @value = linear(@start_value, 1, attack, t)
          end
          if t > attack && t < attack_decay # decay
            return @value = linear(1.0, sustain, decay, t - attack)
          end
          if t >= attack + decay # sustain
            return @value = sustain
          end
        else # release
          if released <= attack # when released in attack phase
            attack_level = linear(@start_value, 1, attack, released)
            return [linear(attack_level, 0, release, t - released), 0].max
          end
          if released > attack && released <= attack_decay # when released in decay phase
            decay_level = linear(1.0, sustain, decay, released - attack)
            return @value = [linear(decay_level, 0, release, t - released), 0].max
          end
          if released > attack_decay  # normal release
            return @value = [linear(sustain, 0, release, t - released), 0].max
          end
        end
        0.0
      end

      private

      def linear(start, target, length, time)
        return start if time == 0
        return target if length == 0
        (target - start) / length * time + start
      end
    end
  end
end