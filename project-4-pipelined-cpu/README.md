# Project 4: 5-Stage Pipelined RISC-V Processor

This is the final and most complex implementation: a 32-bit, **5-Stage Pipelined** RISC-V (RV32I) processor.

### Core Architecture Features:

* **5-Stage Pipeline:** Implements the classic `IF` (Instruction Fetch), `ID` (Instruction Decode), `EX` (Execute), `MEM` (Memory Access), and `WB` (Write Back) stages.
* **Hazard Handling:** The design includes a full **Hazard Detection Unit** and **Data Forwarding Unit** to correctly manage all data and control hazards.
    * **Data Hazards:** Resolved using forwarding paths from the EX/MEM and MEM/WB stages back to the EX stage.
    * **Control Hazards:** Handled by flushing the pipeline on taken branches (e.g., `beq`, `jal`).

### Implemented ISA (RV32I Subset):

* **R-Type:** `add`, `sub`, `and`, `or`, `slt`, `sltu`
* **I-Type:** `lw`, `addi`, `xori`, `ori`, `slti`, `sltiu`, `jalr`
* **S-Type:** `sw`
* **B-Type:** `beq`, `bne`, `blt`, `bge`
* **J-Type:** `jal`
* **U-Type:** `lui`

### Test Program:

The pipelined processor was verified using an assembly program that finds the largest element in a 10-element array of *signed* 32-bit integers.
