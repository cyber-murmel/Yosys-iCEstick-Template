This project shall provide a starting point for new FPGA projects using the
[Lattice Semiconductor iCEstick Evaluation Kit](http://www.latticesemi.com/icestick)
which incorporates the [iCE40HX1K-TQ144](http://www.mouser.com/ds/2/225/iCE40FamilyHandbook-311139.pdf).

## Where to buy
[Mouser](https://eu.mouser.com/ProductDetail/?qs=hJ2CX3hEdVEyBLaHAEXelA%3d%3d)

## How to install the toolchain

[RTFM](http://www.clifford.at/icestorm/)

### Arch Linux

Install the `aur/yosys-git`, `aur/arachne-pnr-git` and `aur/icestorm-git` packages.

If you have `yaourt` installed you can run:
```bash
yaourt -S yosys-git arachne-pnr-git icestorm-git
```

If you don't have permissions to use `iceprog` your user may need to be added to the
group owning the device (e.g. `uucp`).