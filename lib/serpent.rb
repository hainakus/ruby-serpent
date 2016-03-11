require 'json'

require 'serpent/version'
require 'serpent/serpent'

module Serpent
  class <<self
    def mk_signature(s)
      JSON.parse mk_raw_signature(s)
    end

    def mk_full_signature(s)
      JSON.parse mk_raw_full_signature(s)
    end

    def mk_contract_info(s)
      JSON.parse mk_raw_contract_info(s)
    end
  end
end
