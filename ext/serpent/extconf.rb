require 'fileutils'
require 'mkmf-rice'

SOURCE_DIR = File.expand_path('../../../serpent', __FILE__)

INCLUDE_DIR = File.expand_path('../../../include', __FILE__)
SERPENT_INCLUDE_DIR = File.join INCLUDE_DIR, 'libserpent'
LIB_DIR = File.expand_path('../../../lib', __FILE__)

INCLUDE_FILES = %w(
  bignum.h
  util.h
  keccak-tiny-wrapper.h
  tokenize.h
  lllparser.h
  parser.h
  opcodes.h
  functions.h
  optimize.h
  rewriteutils.h
  preprocess.h
  rewriter.h
  compiler.h
  funcs.h
).map {|f| File.join SOURCE_DIR, f }

LIB_FILES = %w(
  libserpent.a
  libserpent.so
).map {|f| File.join SOURCE_DIR, f }

FileUtils.mkdir_p SERPENT_INCLUDE_DIR
FileUtils.mkdir_p LIB_DIR
FileUtils.cp INCLUDE_FILES, SERPENT_INCLUDE_DIR
FileUtils.cp LIB_FILES, LIB_DIR

dir_config('serpent', [INCLUDE_DIR], [LIB_DIR])

abort "missing libserpent.so" unless have_library "serpent"

create_makefile('serpent/serpent')
