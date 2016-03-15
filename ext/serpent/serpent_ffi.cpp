#include "rice/Module.hpp"
using namespace Rice;

#include "libserpent/funcs.h"

std::string serpent_compile(Object self, std::string code) {
	return compile(code);
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
		.define_module_function("mk_signature", &serpent_mk_signature)
		.define_module_function("mk_full_signature", &serpent_mk_full_signature)
		.define_module_function("mk_contract_info", &serpent_mk_contract_info)
		.define_module_function("get_prefix", &serpent_get_prefix);
}
