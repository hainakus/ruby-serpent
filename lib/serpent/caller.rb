# -*- encoding : ascii-8bit -*-

module Serpent
  class Caller

    def compile(code, **kwargs)
      FFI.compile pre_transform(code, kwargs)
    end

    def compile_to_lll(x)
      FFI.compile_lll take(x)
    end

    def parse_to_lll(code)
      FFI.parse_lll(code)
    end

    private

    def take(x)
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
