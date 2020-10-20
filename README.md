# Simple GTP tunnel example

This example make use of libgtpnl from osmocom to create a GTP tunnel
and send some traffic.

## Setup

First, get the example:

```console
git clone https://github.com/abousselmi/gtp-example.git
cd gtp-example
```

Second, you need to clone libgtnl and compile it:

```console
git clone https://git.osmocom.org/libgtpnl
cd libgtpnl
autoreconf -fi
./configure
make
sudo make install
sudo ldconfig
```

Now we need to copy the example script where we have the gtp wrappers:

```console
cp ../example.sh ./tools
cd tools
```

Now you can run the example and enjoy:

```console
./example start
```

To destroy everything, you can do:

```console
./example stop
```

