# Project 2: Single-Cycle RISC-V Processor

This project is the complete implementation of a 32-bit, **Single-Cycle** RISC-V (RV32I) processor. The processor executes each supported instruction in a single clock cycle.

### Architecture:

* **Datapath:** Implemented using a structural design methodology.
* **Control Unit:** A combinational logic circuit that generates all control signals based on the instruction's opcode.

### Implemented ISA (RV32I Subset):

* **R-Type:** `add`, `sub`, `and`, `or`, `slt`, `sltu`
* **I-Type:** `lw`, `addi`, `xori`, `ori`, `slti`, `sltiu`, `jalr`
* **S-Type:** `sw`
* **B-Type:** `beq`, `bne`, `blt`, `bge`
* **J-Type:** `jal`
* **U-Type:** `lui`

### Test Program:

The processor was verified using an assembly program that finds the largest element in a 10-element array of *unsigned* 32-bit integers.
