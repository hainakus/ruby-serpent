$:.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
require 'serpent'

class SerpentTest < Minitest::Test

  def test_compile
    code = <<-SERPENT
def main(a,b):
  return(a ^ b)
    SERPENT

    assert_equal decode_hex('604a80600b6000396055567c0100000000000000000000000000000000000000000000000000000000600035046397d857aa8114156048576004356040526024356060526060516040510a60805260206080f35b505b6000f3'), Serpent.compile(code)
  end

  private

  def encode_hex(s)
    s.unpack('H*').first
  end

  def decode_hex(s)
    [s].pack('H*')
  end

end
