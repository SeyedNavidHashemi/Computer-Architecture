# Computer Architecture: RISC-V Processor Implementation

This repository contains 4 projects from the Computer Architecture course, detailing the step-by-step design and implementation of a 32-bit RISC-V (RV32I) processor in Verilog. The projects progress from implementing a foundational arithmetic unit to a fully functional 5-stage pipelined processor.

##  Project Evolution

* **Project 1: Fixed-Point Divider**
    * A foundational project to build a complex arithmetic unit. This module is a 10-bit unsigned fixed-point divider controlled by a Hoffman-model Finite State Machine (FSM).

* **Project 2: Single-Cycle Processor**
    * The first full processor implementation: a 32-bit **Single-Cycle** RISC-V processor. This design features a structural datapath and a combinational control unit.

* **Project 3: Multi-Cycle Processor**
    * An optimized version of the processor, re-architected to use a **Multi-Cycle** datapath. This design is controlled by a sequential Hoffman-model FSM and reuses functional units across clock cycles.

* **Project 4: 5-Stage Pipelined Processor**
    * The final implementation: a 5-stage pipelined RISC-V core (`IF`, `ID`, `EX`, `MEM`, `WB`). This processor includes full **hazard detection**, **data forwarding**, and branch handling logic to resolve all data and control hazards.

##  Implemented RISC-V ISA (RV32I Subset)

The implemented processors support the following subset of the RV32I instruction set:

* **R-Type:** `add`, `sub`, `and`, `or`, `slt`, `sltu`
* **I-Type:** `lw`, `addi`, `xori`, `ori`, `slti`, `sltiu`, `jalr`
* **S-Type:** `sw`
* **B-Type:** `beq`, `bne`, `blt`, `bge`
* **U-Type:** `lui`
* **J-Type:** `jal`
