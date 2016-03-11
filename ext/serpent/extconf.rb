require 'mkmf-rice'

#include_dir = File.expand_path('../../../include', __FILE__)
#lib_dir = File.expand_path('../../../lib', __FILE__)

#dir_config('serpent', [include_dir], [lib_dir])

abort "missing libserpent.so" unless have_library "serpent"

create_makefile('serpent/serpent')
