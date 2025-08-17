# RISC-V Pipeline Projects

This repository contains Verilog projects that progressively build a 5-stage RISC-V CPU. Each section is in its own branch to show step-by-step development.

## Branches

- **Verilog-Basics** → `V-Basics1.v … V-Basics9.v`  
  Basic Verilog practice and a 1-bit full adder with testbenches.  

- **Datapath-Components** → `CPU.v`, `Components1.v … Components11.v`, `YAdder*`, `YMux*`, `YAlu.v`, `YArith.v`  
  Datapath components: parameterized muxes, 32-bit adders, and a multi-op ALU.  

- **Pipeline-Stages** → `Stages1.v … Stages10.v`  
  Pipeline stages (IF, ID, EX, DM, WB), register file, memory, and branch/jump logic.  

- **CPU-Integration** → `Integration1.v … Integration4.v` (+ final helpers)  
  Control signals, PC selection, and `YChip` integration with program flow.  

## How to Explore
1. Open the **Branch Dropdown**.  
2. Select the branch you want.  
3. Browse the Verilog modules and testbenches.
