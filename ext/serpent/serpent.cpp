#include "rice/Module.hpp"
using namespace Rice;

#include "libserpent/funcs.h"

std::string serpent_compile(Object self, std::string code) {
	return compile(code);
}

extern "C"
void Init_serpent() {
	Module rb_mSerpent = define_module("Serpent")
		.define_module_function("compile", &serpent_compile);
}
