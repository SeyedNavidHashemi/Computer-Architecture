# Project 1: 10-bit Unsigned Fixed-Point Divider

This project is the design and implementation of a 10-bit unsigned fixed-point divider in Verilog.

### Key Features:

* **Architecture:** The module processes 10-bit inputs for the dividend and divisor, formatted as unsigned fixed-point numbers with 6 integer bits and 4 fractional bits. The quotient output follows the same 10-bit format.
* **Control Unit:** The divider's operation is managed by a sequential **Hoffman-model Finite State Machine (FSM)**.
* **Datapath:** The datapath is implemented using structural Verilog, following the provided shift-and-subtract algorithm.
* **Interface:**
    * Inputs: `a_in` (dividend), `b_in` (divisor), `start`, `sclr` (synchronous reset), `clk`.
    * Outputs: `q_out` (quotient), `dvz` (divide by zero), `ovf` (overflow), `busy`, `valid`.
* **Algorithm:** Implements the specified division algorithm over 14 iterations to produce the final quotient.
