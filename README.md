# [Yosys-iCEstick-Template](https://github.com/cyber-murmel/Yosys-iCEstick-Template)

This project shall provide a starting point for new FPGA projects using the
[Lattice Semiconductor iCEstick Evaluation Kit](http://www.latticesemi.com/icestick)
which incorporates the [iCE40HX1K-TQ144](http://www.mouser.com/ds/2/225/iCE40FamilyHandbook-311139.pdf).

You can simply fork this repo and use it as the framework for your code.

Additions and bugfixes are very welcome.

Happy Hacking!

![gif](https://raw.githubusercontent.com/wiki/cyber-murmel/Yosys-iCEstick-Template/example.gif)

## Where to buy
[Mouser](https://eu.mouser.com/ProductDetail/?qs=hJ2CX3hEdVEyBLaHAEXelA%3d%3d)

## How to install the toolchain

### Arch Linux

Install the `community/iverilog` `community/gtkwave` `aur/verilator`, `aur/yosys-git`, `aur/arachne-pnr-git` and `aur/icestorm-git` packages.

If you have `yaourt` installed you can run:
```bash
yaourt -S iverilog gtkwave verilator yosys-git arachne-pnr-git icestorm-git
```

If you don't have permissions to use `iceprog` your user may need to be added to the
group owning the device (e.g. `uucp`).

### Other

[RTFM](http://www.clifford.at/icestorm/)

#### Installing Prerequisites on Debian Based Systems
If you are running a Debian based system (e.g. Debian, Ubuntu, Linux Mint) yout can run
the following commands:
```bash
sudo apt-get install build-essential clang bison flex libreadline-dev \
    gawk tcl-dev libffi-dev git mercurial graphviz   \
    xdot pkg-config python python3 libftdi-dev
sudo apt-get install iverilog gtkwave
```

#### Installing Prerequisites on Fedora Based Systems
```bash
sudo dnf install make automake gcc gcc-c++ kernel-devel clang bison \
    flex readline-devel gawk tcl-devel libffi-devel git mercurial \
    graphviz python-xdot pkgconfig python python3 libftdi-devel
sudo dnf install iverilog gtkwave
```

#### Clone and Install tools
```bash
git clone https://github.com/cliffordwolf/yosys.git yosys
git clone https://github.com/cseed/arachne-pnr.git arachne-pnr
git clone https://github.com/cliffordwolf/icestorm.git icestorm
make -C yosys
make -C arachne-pnr
make -C icestorm
sudo make -C yosys install
sudo make -C arachne-pnr install
sudo make -C icestorm install
```

## Extras
[iCE40 Viewer](https://knielsen.github.io/ice40_viewer/ice40_viewer.html)