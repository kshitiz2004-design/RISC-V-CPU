# RISC-V CPU Design Using Verilog HDL

A modular RISC-V processor implementation using **Verilog HDL**, designed to explore processor architecture, instruction execution, pipelining, and digital system design. The project is simulated using **ModelSim**.

## Overview

This project implements a RISC-V CPU using separate Verilog modules for instruction fetching, instruction decoding, execution, memory access, and write-back. The processor integrates an ALU, register file, control logic, and instruction/data memory interfaces to execute instructions through a structured datapath.

The project demonstrates practical concepts in **RTL design, processor datapaths, control signals, memory interfacing, and hardware simulation**.

## Architecture

The processor is organized into five logical processing stages:
-Instruction Fetch(IF)
-Instruction Decode(ID)
-Instruction Execute(IE)
-Memory(MEM)
-Writeback(WB)
<img width="1313" height="670" alt="Screenshot 2026-10-16 030044" src="https://github.com/user-attachments/assets/27161713-5283-4917-98e2-51e1bcfd056a" />



### Pipeline Stages

- **Instruction Fetch (IF):** Maintains the program counter, fetches instructions from instruction memory, and calculates the next sequential PC.
- **Instruction Decode (ID):** Decodes instructions, reads source registers, generates control signals, and prepares immediate operands.
- **Execute (EX):** Performs ALU operations, evaluates branch conditions, calculates jump or branch targets, and propagates execution results.
- **Memory Access (MEM):** Interfaces with data memory for memory-related instructions and forwards data to the next stage.
- **Write Back (WB):** Selects the appropriate result, such as an ALU result, memory data, or a return address, for writing back to the register file.

## Key Modules

Verilog File | Function |
risc_v.v               Top-level processor integration 
InstructionFetch.v     Program counter and instruction fetching
Instruction Decode.v   Instruction decoding and register operand preparation 
Control Unit.v         Generation of processor control signals 
Decodermain.v          Main decoder logic 
ALU_decoder.v          ALU operation decoding 
ALU.v                  Arithmetic and logical operations 
Execute.v              Execution logic and pipeline signal propagation 
Memory                 Instruction.v Instruction memory implementation 
Datamemory.v           Data memory implementation 
Memory.v               Memory-stage integration 
Register_File.v        Register storage and read/write operations 
Writeback.v            Selection of the result written back 
memfile.hex            Instruction memory initialization data 

## Technologies Used

- **Hardware Description Language:** Verilog HDL
- **Simulation Environment:** ModelSim
- **Development Environment:** Visual Studio Code
- **Version Control:** Git and GitHub

## Simulation Using ModelSim

### Prerequisites

1. Install ModelSim or a compatible Questa/ModelSim simulator.
2. Clone or download this repository.
3. Ensure all Verilog source files and the `memfile.hex` file are available in the working directory.
4. Prepare a testbench that instantiates the top-level `RISC_V` module and generates clock and reset signals.

### Step 1: Clone the Repository

```bash
git clone https://github.com/kshitiz2004-design/RISC-V-CPU.git
cd RISC-V-CPU
```

### Step 2: Create a Simulation Library

In the ModelSim Transcript window:

```tcl
vlib work
```

### Step 3: Compile the Design

Compile the Verilog modules in dependency order, beginning with the ALU and its decoder, followed by memory and register modules, pipeline stages, and the top-level module.

For example:

```tcl
vlog ALU.v
vlog ALU_decoder.v
```

Continue compiling the remaining source files, accounting for filenames containing spaces and resolving any compilation errors.

### Step 4: Compile the Testbench

If your testbench is named `riscv_tb.v`:

```tcl
vlog riscv_tb.v
```

### Step 5: Launch the Simulation

```tcl
vsim work.riscv_tb
```

Add the relevant signals to the waveform viewer:

```tcl
add wave -r /*
```

Run the simulation:

```tcl
run -all
```

**Note:** These commands illustrate the simulation workflow. The repository must compile successfully, and the testbench and source files must match their actual module names and interfaces before the simulation will run.

## Expected Simulation Observations

During simulation, inspect the following signals in the ModelSim waveform viewer:

- Clock and reset.
- Program counter and fetched instruction.
- Decoded source-register values and immediate operands.
- ALU operation and execution result.
- Branch and jump control signals.
- Memory read/write signals and data.
- Destination register and write-back result.

The waveform viewer allows you to observe signal transitions over simulation time and investigate the processor's behavior. Successful execution should be confirmed by checking the expected register or memory values for the instructions loaded into `memfile.hex`.

## Learning Outcomes

Through this project, the following concepts are explored:

- RTL design and modular Verilog coding.
- RISC-V processor datapath organization.
- Instruction decoding and control-signal generation.
- Arithmetic and logical unit design.
- Register-file and memory interfacing.
- Branch and jump control logic.
- Functional verification using testbenches and ModelSim waveforms.
- Version control and hardware-design project documentation.

## Future Improvements

Potential enhancements include:

- Adding data forwarding and hazard detection where required.
- Improving branch handling and pipeline control.
- Evaluating synthesis results and FPGA implementation.

## Repository

GitHub: https://github.com/kshitiz2004-design/RISC-V-CPU

## Author

**Kshitiz Gupta**

Electrical Engineering Undergraduate  
NIT Kurukshetra

---

*This project is intended for educational exploration of processor architecture and digital hardware design.*
