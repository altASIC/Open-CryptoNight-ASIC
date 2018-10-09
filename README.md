# Project OCA (Open CryptoNight ASIC)
:heavy_check_mark: Open source.  
:heavy_check_mark: Permissive Licensing.  
:heavy_check_mark: __5x better performance than Bitmain__  
:heavy_check_mark:  Made with love by [7400digital@gmail.com](http://www.7400.digital/), [Tim Olson](https://linkedin.com/in/olsontim), and [Salt](https://twitter.com/_vhsv3).  Together we are [altASIC](http://altasic.com/).

## What is this

This is the essential core code for altASIC's CryptoNight ASIC design.
It mines "classic" pre-v7 CryptoNight and can run in simulation, on FPGA, or as an ASIC.

This code represents only the essential "memory hard" part of CryptoNight.
altASIC additionally has a complete hardware system design with a software controller,
an FPGA for initial/final hashes, a high-speed IO bus and logic board,
and state-of-the-art power management.

## Why make a CryptoNight design?

We believe specialized mining hardware is inevitable for any proof-of-work.  Even
proofs-of-work bounded by memory bandwidth, like Ethash or Equihash, have custom hardware 
(ASIC's) which outperform commodity hardware (GPU's) by economically large multiples.
There is __no__ proof of work which has in practice prevented the development of specialized 
hardware miners for coins with sufficient mining value. 

ASICs can be beneficial to a chain, since the hashpower can only work on the subset of coins which
select the same PoW. The problem arises with the centralization of manufacturing, and the abuse of 
power by ASIC manufacturers.

If custom hardware is inevitable, then creative solutions to the threat of manufacturing monopolies
must be considered.  Some approaches we believe could be feasible:
- __Community effort to publicly publish the most efficient design with open licensing__.  This allows anyone 
with the money to produce equivalent chips, leading to many competing companies and close to at-cost ASICs.
-  __Non-profit chip design co-op, subsidized by a small portion of the block reward and run by distributed
governance.__  Any for-profit company competing with a blockchain-subsidized Open ASIC manufacturer would
have a disadvantage equal to the block donation. This effectively moves the monopoly to a community owned 
and operated manufacturer.

We believe Open ASICs are the way forward.
Long term, the CN tweak schedule and creative new PoWs will be defeated.
Rather than evade, we should accelerate commodity ASICs.
This open source design is the first step in that direction,
and we'd be interested in helping to establish a design co-op and release the first chip.

## Performance
Each inner loop iteration runs in 4 clock cycles, yielding a total inner loop time of 2.1 million cycles.
The initialization loop and finalization loops operate at 5 clock cycles per iteration in this configuration,
bringing the total up to 3.4 million.
But the IL and FL can be parallelized even further.

Memory utilization is 100% during the inner loop, and 20% during initialization and finalization loops.
So overall Memory utilization is 69%.

The initial and final Keccak and other finalization hashes can be run on a CPU or FPGA 
in parallel with the memory-hard algorithm on the ASIC,
so those hashes do not reduce performance in a well-designed ASIC mining system.

### ASIC implementation
Physical layout was completed vs TSMC 28nm process and parasitics extracted.
Size of a single core was 4mm<sup>2</sup>.
Clock rate was 800MHz, limited by RAM tpd.
Power simulation measured 400 μJ per hash.
Overall this is ~5x better than the Bitmain X3.

### FPGA implementation
The 16 Mib memory requirement of CryptoNight means that instantiating the full core
requires a relatively expensive FPGA to get enough RAM blocks,
even though most of the logic units go unused.
Implementation on an Arria A10 development board runs 30H/s per core at 100MHz.

While FPGA's are not economically viable for mining CryptoNight,
an FPGA implementation is useful for validation of the entire stack.
It is relatively easy to splice the design running on an FPGA
into an XMR CPU Miner to replace the memory hard loop and mine actual shares.

## Testbench

Icarus Verilog version 10+ is required.  Ubuntu's package archive still has an old version,
so Ubuntu users need to install manually from the
[latest release](https://github.com/steveicarus/iverilog).

The testbench input vector is the 200-byte initial Keccak state,
and the ASIC returns the 200-byte modified Keccak state.

CryptoNight's inner loop is of order 10<sup>6</sup>,
and Icarus Verilog takes hours to simulate a single hash.
So for development purposes,
we use a mode with a reduced number of inner-loop iterations that runs in seconds.

Running `make` will run in development mode and complete in a few seconds.
To run the full test, comment out this line in the Makefile:

```SPEEDUP_MODE="-DSPEEDUP_MODE"```
