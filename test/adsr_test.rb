require 'test_helper'
require_relative '../lib/synth_blocks/mod/adsr'

module SynthBlocks
  module Mod
    class AdsrTest < Minitest::Test
      def test_attack
        adsr = Adsr.new(1, 1, 1, 1)

        assert_equal 0.5, adsr.run(0.5, nil)
        assert_equal 1, adsr.run(1, nil)
      end

      def test_decay
        adsr = Adsr.new(1, 1, 0.5, 1)
        assert_equal 1, adsr.run(1, nil)
        assert_equal 0.75, adsr.run(1.5, nil)
        assert_equal 0.5, adsr.run(2.5, nil)
      end

      def test_sustain
        adsr = Adsr.new(1, 1, 0.5, 1)
        assert_equal 0.5, adsr.run(2.5, nil)
      end

      def test_release_in_decay
        adsr = Adsr.new(1, 1, 0.5, 1)
        assert_equal 0.0, adsr.run(0, nil)
        assert_equal 1.0, adsr.run(1, nil)
        assert_equal 1.0, adsr.run(1, 1)
        assert_equal 0.75, adsr.run(1.5, 1)
        assert_equal 0.625, adsr.run(1.75, 1)
        assert_equal 0.5, adsr.run(2, 1)
        assert_equal 0.375, adsr.run(2.25, 1)
        assert_equal 0.25, adsr.run(2.5, 1)
        assert_equal 0.125, adsr.run(2.75, 1)
        assert_equal 0.0, adsr.run(3, 1)
      end

      def test_release_in_attack
        adsr = Adsr.new(1, 0.5, 0.5, 1)
        assert_equal 0.0, adsr.run(0, nil)
        assert_equal 0.5, adsr.run(0.5, nil)
        assert_equal 0.5, adsr.run(0.5, 0.5)
        assert_equal 0.25 + 0.125, adsr.run(0.75, 0.5)
        assert_equal 0.25, adsr.run(1, 0.5)
        assert_equal 0.25 - 0.125, adsr.run(1.25, 0.5)
        assert_equal 0, adsr.run(1.5, 0.5)
        assert_equal 0, adsr.run(2, 0.5)
      end

      def test_release_in_sustain
        adsr = Adsr.new(1, 1, 0.5, 1)

        assert_equal 0.5, adsr.run(0.5, nil)
        assert_equal 1, adsr.run(1, nil)
        assert_equal 0.75, adsr.run(1.5, nil)
        assert_equal 0.5, adsr.run(2, nil)
        assert_equal 0.5, adsr.run(2.5, nil)
        assert_equal 0.5, adsr.run(2.5, 2.5)
        assert_equal 0.25, adsr.run(3, 2.5)
        assert_equal 0, adsr.run(3.5, 2.5)
        assert_equal 0, adsr.run(4, 2.5)
      end
    end
  end
end
