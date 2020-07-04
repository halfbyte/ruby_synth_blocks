module SynthBlocks
  module Core
    class OnePoleLP # :nodoc:
      def initialize
        @outputs = 0.0
      end
      
      def run(input, cutoff)
        p = (cutoff * 0.98) * (cutoff * 0.98) * (cutoff * 0.98) * (cutoff * 0.98);
        @outputs = (1.0 - p) * input + p * @outputs
      end
    end
  end
end