# -*- encoding : ascii-8bit -*-

module Serpent
  class Caller

    N = 2**32

    def compile(code, **kwargs)
      FFI.compile pre_transform(code, kwargs)
    end

    def compile_to_lll(code, **kwargs)
      Node.build FFI.compile_to_lll(pre_transform(code, kwargs))
    end

    def compile_lll(code)
      FFI.compile_lll ast(code)
    end

    def get_prefix(signature)
      FFI.get_prefix(signature) % N
    end

    def mk_signature(code, **kwargs)
      JSON.parse FFI.mk_signature(pre_transform(code, kwargs))
    end

    def mk_full_signature(code, **kwargs)
      JSON.parse FFI.mk_full_signature(pre_transform(code, kwargs))
    end

    def mk_contract_info(code, **kwargs)
      JSON.parse FFI.mk_contract_info(pre_transform(code, kwargs))
    end

    private

    def ast(x)
      x.instance_of?(String) ? FFI.parse_lll(x) : x.out
    end

    def pre_transform(code, params)
      code2 = ''
      params.each do |k, v|
        v = %{"#{v}"} if v.instance_of?(String)
        code2 += "macro $#{k}:\n  #{v}\n"
      end

      if File.exist?(code)
        code2 + "inset('#{code}')"
      else
        code2 + code
      end
    end

  end
end
