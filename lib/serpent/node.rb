# -*- encoding : ascii-8bit -*-

module Serpent
  module Node

    class Metadata
      def initialize(ary)
        @file = ary[0]
        @ln = ary[1]
        @ch = ary[2]
      end

      def out
        [@file, @ln, @ch]
      end
    end

    class Token
      def initialize(val, metadata)
        @val = val
        @metadata = metadata
      end

      def out
        [0, @val, @metadata.out]
      end

      def to_s
        @val.to_s
      end
      alias :inspect :to_s
    end

    class Astnode
      def initialize(val, args, metadata)
        @val = val
        @args = args.map {|arg| Node.build arg }
        @metadata = Metadata.new(metadata)
      end

      def out
        [1, @val, @metadata.out] + @args.map(&:out)
      end

      def to_s
        o = "(#{@val}"
        subs = @args.map(&:to_s)

        k = 0
        out = " "
        while k < subs.size && o != "(seq"
          break if subs[k].include?("\n") || (out + subs[k]).size >= 80
          out += subs[k] + " "
          k += 1
        end

        if k < subs.size
          o += out + "\n  "
          o += subs[k..-1].join("\n").split("\n").join("\n  ")
          o += "\n)"
        else
          o += out[0...-1] + ')'
        end

        o
      end
      alias :inspect :to_s
    end

    def self.build(ary)
      if ary[0] == 0
        Token.new ary[1], ary[2]
      else
        args = ary.size > 3 ? ary[3..-1] : []
        Astnode.new ary[1], args, ary[2]
      end
    end

  end
end
