#include "rice/Class.hpp"
#include "rice/String.hpp"

using namespace Rice;

Object test_hello(Object /* self */) {
	String str("hello world");
	return str;
}

extern "C"
void Init_serpent() {
	Module rb_cTest = define_module("Serpent")
		.define_method("hello", &test_hello);
}
