#include "rice/Module.hpp"
#include "rice/Array.hpp"
using namespace Rice;

#include "libserpent/util.h"
#include "libserpent/parser.h"
#include "libserpent/funcs.h"

Array serialize_metadata(Metadata m) {
	Array a;
	a.push(m.file);
	a.push(m.ln);
	a.push(m.ch);
	return a;
}

Array serialize_node(Node n) {
	Array a;
	a.push(n.type);
	a.push(n.val);
	a.push(serialize_metadata(n.metadata));
	for(unsigned i = 0; i < n.args.size(); i++)
		a.push(serialize_node(n.args[i]));
	return a;
}

Metadata deserialize_metadata(Array o) {
	return Metadata(from_ruby<std::string>(o[0]),
			from_ruby<int>(o[1]),
			from_ruby<int>(o[2]));
}

Node deserialize_node(Array o) {
	Node n;

	n.type = from_ruby<int>(o[0]) ? ASTNODE : TOKEN;
	n.val = from_ruby<std::string>(o[1]);
	n.metadata = deserialize_metadata(from_ruby<Array>(o[2]));

	std::vector<Node> args;
	for(unsigned i = 3; i < o.size(); i++) {
		args.push_back(deserialize_node(from_ruby<Array>(o[i])));
	}
	n.args = args;

	return n;
}

/*
 * Serpent functions
 */

std::string serpent_compile(Object self, std::string code) {
	return compile(code);
}

//std::string serpent_compile_lll(Object self, Node program) {
	//return compileLLL(program);
//}

Array serpent_compile_to_lll(Object self, std::string code) {
	return serialize_node(compileToLLL(code));
}

Array serpent_parse_lll(Object self, std::string code) {
	return serialize_node(parseLLL(code));
}

std::string serpent_compile_lll(Object self, Array o) {
	Node n = deserialize_node(o);
	return compileLLL(n);
}

std::string serpent_mk_signature(Object self, std::string input) {
	return mkSignature(input);
}

std::string serpent_mk_full_signature(Object self, std::string input) {
	return mkFullSignature(input);
}

std::string serpent_mk_contract_info(Object self, std::string input) {
	return mkContractInfoDecl(input);
}

unsigned int serpent_get_prefix(Object self, std::string signature) {
	return getPrefix(signature);
}

extern "C"
void Init_serpent_ffi() {
	Module rb_mSerpent = define_module("Serpent");

	Module rb_mSerpentFFI = define_module_under(rb_mSerpent, "FFI")
		.define_module_function("compile", &serpent_compile)
		.define_module_function("compile_to_lll", &serpent_compile_to_lll)
		.define_module_function("parse_lll", &serpent_parse_lll)
		.define_module_function("compile_lll", &serpent_compile_lll)
		.define_module_function("mk_signature", &serpent_mk_signature)
		.define_module_function("mk_full_signature", &serpent_mk_full_signature)
		.define_module_function("mk_contract_info", &serpent_mk_contract_info)
		.define_module_function("get_prefix", &serpent_get_prefix);
}
