# ruby-serpent

## Install

Make sure you already have [libserpent](https://github.com/ethereum/serpent/tree/develop) at location.

```
gem i serpent
```

## Dev Build

```
git submodule sync
git submodule update

# compile and install libserpent
cd serpent
make
sudo make install
cd ..

# compile extension
rake compile

# run test
rake
```

## Usage

Check test for examples.

## LICENSE

[MIT License](LICENSE)

## References

* [Ethereum](http://ethereum.org)
* [Serpent](https://github.com/ethereum/wiki/wiki/Serpent)

