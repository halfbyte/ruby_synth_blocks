require_relative 'synth_blocks/core/sound'
# require_relative 'synth_blocks/mod/adsr'
require_relative 'synth_blocks/mod/adsr'
require_relative 'synth_blocks/fx/chorus'
require_relative 'synth_blocks/fx/compressor'
require_relative 'synth_blocks/fx/delay'
require_relative 'synth_blocks/mod/envelope'
require_relative 'synth_blocks/fx/eq'
require_relative 'synth_blocks/fx/g_verb'
require_relative 'synth_blocks/drum/hihat'
require_relative 'synth_blocks/drum/kick_drum'
require_relative 'synth_blocks/drum/tuned_drum'
require_relative 'synth_blocks/mixer/mixer_channel'
require_relative 'synth_blocks/synth/monosynth'
require_relative 'synth_blocks/core/moog_filter'
require_relative 'synth_blocks/core/oscillator'
require_relative 'synth_blocks/synth/polysynth'
require_relative 'synth_blocks/mixer/send_channel'
require_relative 'synth_blocks/sequencer/sequencer_dsl'
require_relative 'synth_blocks/drum/snare_drum'
require_relative 'synth_blocks/core/state_variable_filter'
require_relative 'synth_blocks/utils'
require_relative 'synth_blocks/fx/waveshaper'
require_relative 'synth_blocks/fx/limiter'
require_relative 'synth_blocks/core/wave_writer'

unless RUBY_ENGINE == 'opal'
  # Now if we are NOT running inside of opal, set things up so opal can find
  # the files. The whole thing is rescued in case the opal gem is not available.
  # This would happen if the gem is being used server side ONLY.
  begin
    require 'opal'
    Opal.append_path File.expand_path('..', __FILE__).untaint
  rescue LoadError
  end
end