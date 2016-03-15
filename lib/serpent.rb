# -*- encoding : ascii-8bit -*-

require 'json'

require 'serpent/version'
require 'serpent/serpent_ffi'
require 'serpent/caller'

module Serpent

  extend self

  def compile(code, **kwargs)
    Caller.new.compile code, **kwargs
  end

  def get_prefix(signature)
    FFI.get_prefix signature
  end

  def mk_signature(s)
    JSON.parse FFI.mk_signature(s)
  end

  def mk_full_signature(s)
    JSON.parse FFI.mk_full_signature(s)
  end

  def mk_contract_info(s)
    JSON.parse FFI.mk_contract_info(s)
  end

end
