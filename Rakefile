require 'rake/extensiontask'
require 'rake/testtask'

require 'fileutils'

Rake::ExtensionTask.new "serpent_ffi" do |ext|
  ext.ext_dir = 'ext/serpent'
  ext.lib_dir = 'lib/serpent'
end

Rake::TestTask.new do |t|
  t.libs += %w(lib test)
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

task default: [:test]
