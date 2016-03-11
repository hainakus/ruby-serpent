#include "rice/Class.hpp"
#include "rice/String.hpp"

#include "libserpent/funcs.h"

using namespace Rice;

std::string serpent_compile(Object self, std::string code) {
	return compile(code);
}

extern "C"
void Init_serpent() {
	Module rb_mSerpent = define_module("Serpent")
		.define_module_function("compile", &serpent_compile);
}
