module SynthBlocks
  module Mod
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
        @start_time = 0
        @last_t = 0
        @done = false
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
        delta = t - @last_t
        @last_t = t
        if released
          return 0 if @done
          @value += -(@sustain/@release) * (t - released)
          if @value <= 0
            @value = 0
            @done = true
          end
          return @value
        else
          if t < 0.0001 # initialize start value (slightly hacky, but works)
            @start_time = t
            return @value
          end
          if t <= @attack
            return @value += 1/@attack * delta
          elsif t <= @attack + @decay
            return @value += -(1-@sustain)/@decay * delta
          else
            return @value = @sustain
          end
        end 
        @a_s = 1 / @attack
      end
    end
  end
end
