require 'mkmf-rice'

abort "missing libserpent.so" unless have_library "serpent"

create_makefile('serpent/serpent')
