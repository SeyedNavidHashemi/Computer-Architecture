# Project 3: Multi-Cycle RISC-V Processor

This project re-implements the RISC-V processor using a **Multi-Cycle** architecture. This design is more hardware-efficient, as it allows functional units (like the ALU and memory) to be reused across different clock cycles.

### Architecture:

* **Datapath:** A structural design optimized for multi-cycle operation.
* **Control Unit:** Implemented as a sequential logic circuit using a **Hoffman-model Finite State Machine (FSM)**. The FSM transitions through different states to execute each instruction over several cycles.

### Implemented ISA (RV32I Subset):

* **R-Type:** `add`, `sub`, `and`, `or`, `slt`, `sltu`
* **I-Type:** `lw`, `addi`, `xori`, `ori`, `slti`, `sltiu`, `jalr`
* **S-Type:** `sw`
* **B-Type:** `beq`, `bne`, `blt`, `bge`
* **J-Type:** `jal`
* **U-Type:** `lui`

### Test Program:

The processor was verified using an assembly program that finds the largest element in a 10-element array of *unsigned* 32-bit integers.
