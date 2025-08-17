# Pipelined-RISC-V-CPU
This repository contains Verilog projects that progressively build a 5-stage RISC-V CPU.  
Each section is in its own branch to show step-by-step development.

## Branches

- **Verilog-Basics** → `Labk1.v … Labk9.v`  
  Basic Verilog practice and a 1-bit full adder with testbenches.  

- **Datapath-Components** → `cpu.v`, `LabL1.v … LabL11.v`, `yAdder*`, `yMux*`, `yAlu.v`, `yArith.v`  
  Datapath components: parameterized muxes, 32-bit adders, and a multi-op ALU.  

- **Pipeline-Stages** → `LabM1.v … LabM10.v`  
  Pipeline stages (IF, ID, EX, DM, WB), register file, memory, and branch/jump logic.  

- **Cpu-Integration** → `LabN1.v … LabN4.v` (+ final helpers)  
  Control signals, PC selection, and `yChip` integration with program flow.  

## How to Explore
1. Open the **branch dropdown** (next to “main”).  
2. Select the branch you want.  
3. Browse the Verilog modules and testbenches.
