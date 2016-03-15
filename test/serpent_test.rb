# -*- encoding : ascii-8bit -*-
$:.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
require 'serpent'

class SerpentTest < Minitest::Test

  CODE = <<EOF
def main(a,b):
  return(a ^ b)
EOF

  def test_compile
    assert_equal decode_hex('604a80600b6000396055567c0100000000000000000000000000000000000000000000000000000000600035046397d857aa8114156048576004356040526024356060526060516040510a60805260206080f35b505b6000f3'), Serpent.compile(CODE, foo: 1)
  end

  def test_compile_to_lll
    assert_match /^\(return 0 \n/, Serpent.compile_to_lll(CODE).to_s
  end

  def test_parse_lll
    assert_equal [0, 'def', ['main', 0, 0]], Serpent::FFI.parse_lll(CODE)
  end

  def test_mk_full_signature
    sig = Serpent.mk_full_signature(CODE).first
    assert_equal 'main(int256,int256)', sig['name']
    assert_equal [{'name' => 'a', 'type' => 'int256'}, {'name' => 'b', 'type' => 'int256'}], sig['inputs']
  end

  private

  def encode_hex(s)
    s.unpack('H*').first
  end

  def decode_hex(s)
    [s].pack('H*')
  end

end
