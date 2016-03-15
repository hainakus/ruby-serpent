# -*- encoding : ascii-8bit -*-

require 'json'

require 'serpent/version'
require 'serpent/serpent_ffi'
require 'serpent/node'
require 'serpent/caller'

module Serpent

  class <<self
    def method_missing(name, *args)
      caller = Caller.new
      if caller.respond_to?(name)
        caller.send name, *args
      else
        super
      end
    end
  end

end
