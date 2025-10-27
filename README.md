# Computer Architecture: RISC-V Processor Implementation

This repository contains 4 projects from the Computer Architecture course, detailing the step-by-step design and implementation of a 32-bit RISC-V (RV32I) processor in Verilog. The projects progress from implementing a foundational arithmetic unit to a fully functional 5-stage pipelined processor.

##  Project Evolution

* **Project 1: Fixed-Point Divider**
    * A foundational project to build a complex arithmetic unit. [cite_start]This module is a 10-bit unsigned fixed-point divider [cite: 1352] [cite_start]controlled by a Hoffman-model Finite State Machine (FSM)[cite: 1443].

* **Project 2: Single-Cycle Processor**
    * [cite_start]The first full processor implementation: a 32-bit **Single-Cycle** RISC-V processor[cite: 547]. [cite_start]This design features a structural datapath and a combinational control unit[cite: 570].

* **Project 3: Multi-Cycle Processor**
    * [cite_start]An optimized version of the processor, re-architected to use a **Multi-Cycle** datapath[cite: 520]. [cite_start]This design is controlled by a sequential Hoffman-model FSM [cite: 543] and reuses functional units across clock cycles.

* **Project 4: 5-Stage Pipelined Processor**
    * [cite_start]The final implementation: a 5-stage pipelined RISC-V core (`IF`, `ID`, `EX`, `MEM`, `WB`)[cite: 317]. [cite_start]This processor includes full **hazard detection**, **data forwarding**, and branch handling logic to resolve all data and control hazards[cite: 336].

##  Implemented RISC-V ISA (RV32I Subset)

The implemented processors support the following subset of the RV32I instruction set:

* [cite_start]**R-Type:** `add`, `sub`, `and`, `or`, `slt`, `sltu` [cite: 320, 523, 550]
* [cite_start]**I-Type:** `lw`, `addi`, `xori`, `ori`, `slti`, `sltiu`, `jalr` [cite: 322, 525, 552]
* [cite_start]**S-Type:** `sw` [cite: 325, 528, 555]
* [cite_start]**B-Type:** `beq`, `bne`, `blt`, `bge` [cite: 331, 534, 561]
* [cite_start]**U-Type:** `lui` [cite: 334, 537, 564]
* [cite_start]**J-Type:** `jal` [cite: 328, 531, 558]
