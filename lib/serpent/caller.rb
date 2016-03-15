# -*- encoding : ascii-8bit -*-

module Serpent
  class Caller

    def compile(code, **kwargs)
      FFI.compile pre_transform(code, kwargs)
    end

    def compile_to_lll(code, **kwargs)
      Node.build FFI.compile_to_lll(pre_transform(code, kwargs))
    end

    def compile_lll(code)
      FFI.compile_lll ast(code)
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
