# Single-Cycle MIPS Processor

## Overview

This project implements a 32-bit Single-Cycle MIPS processor using Verilog HDL. The processor executes each instruction in one clock cycle, following the classic single-cycle datapath architecture.

The design supports R-type, I-type, and J-type instructions

---

## Supported Instruction Set (15 Instructions)

### R-Type Instructions

* AND
* OR
* ADD
* SUB
* MULT
* SLT
* NOR
* SLL
* SRL
* SRA

### I-Type Instructions

* LW (Load Word)
* SW (Store Word)
* BEQ (Branch if Equal)
* ADDI (Add Immediate)
* ANDI (AND Immediate)

### J-Type Instructions

* J (Jump)

---

## Architecture Description

### 1. Program Counter (PC)

* 32-bit register
* Increments by 4 every clock cycle
* Supports branch and jump redirection

### 2. Instruction Memory

* Word-addressable memory
* Indexed using PC[9:2]
* Loaded using $readmemh for simulation

### 3. Register File

* 32 general-purpose registers
* Two read ports
* One write port
* Register 0 is hardwired to zero

### 4. ALU

Performs arithmetic, logical, comparison, multiplication, and shift operations.

Supported operations:

* Arithmetic: ADD, SUB, ADDI
* Logical: AND, OR, NOR, ANDI
* Comparison: SLT
* Multiply: MULT
* Shift: SLL, SRL, SRA

### 5. Data Memory

* Word-addressable
* Supports LW and SW
* Indexed using address[9:2]

### 6. Control Unit

Generates control signals based on opcode and funct fields:

* RegDst
* ALUSrc
* MemtoReg
* RegWrite
* MemRead
* MemWrite
* Branch
* Jump
* ALUControl

---

## Datapath Characteristics

* Single-cycle execution
* No pipelining
* Combinational ALU and control logic
* Separate instruction and data memories
* Branch target = PC + 4 + (SignExtImm << 2)
* Jump target = {PC[31:28], instr[25:0], 2'b00}

---

## Simulation

Instructions, registers are loaded in the testbench using:

```
$readmemb("inst_mem.dat", dut.U_datapath.U_IF.INSTR_MEM.inst_mem);
$readmemh("registers.dat", dut.U_datapath.U_EX.reg_file.registers);
```

---

## Limitations

* Single-cycle design limits maximum clock frequency
* No hazard detection (non-pipelined design)

---

## Future Improvements

* Add support for more MIPS instructions
* Upgrade to pipelined architecture
* Add forwarding and hazard detection
* Implement test automation with coverage metrics
