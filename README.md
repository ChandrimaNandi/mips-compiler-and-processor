# MIPS Processor Implementation in Python

## Overview
This project implements a non-pipelined MIPS processor using Python. The processor executes machine code instructions in 5 phases: Instruction Fetch, Instruction Decode, Execute, Memory, and Write Back.

## Features
- Control signals generation
- MUX to decide inputs and outputs conditionally
- ALU (Arithmetic Logic Unit) implementation
- Hazard Detection and forwarding unit
- Pipeline flush

## Usage
- Run the program with the provided machine code (a sorting algorithm)
- The program will execute the instructions and print the number of clock cycles taken to execute all instructions

## Assumptions and Limitations
- The number of inputs and outputs is restricted to 10
- Inputs are initialized to specific registers as done in Assignment-1

## Code Structure
The code consists of the following phases:

- Instruction Fetch: Fetches instructions from the machine_code dictionary
- Instruction Decode: Decodes the binary instruction into fields like rs, rt, rd, funct, etc.
- Control Unit: Generates control signals to decide the flow of the program
- Execute: Performs various operations based on the control signals
- Memory: Writes data to memory or extracts data from memory
- Write Back: Writes data back to the register file

# Non-Pipelined MIPS Processor Implementation in Python

## Overview
This project implements a non-pipelined MIPS processor using Python. The processor takes machine code as input, executes the instructions in 5 phases (Instruction Fetch, Instruction Decode, Execute, Memory, and Write Back), and prints the number of clock cycles taken to execute all instructions.

## Processor Components
- Instruction Fetch: Fetches instructions from the instruction memory.
- Instruction Decode: Decodes the binary instruction into fields like rs, rt, rd, funct, etc.
- Control Unit: Generates control signals to decide the flow of the program.
- ALU (Arithmetic Logic Unit): Performs arithmetic and logical operations.
- Memory: Writes data to memory or extracts data from memory.
- Write Back: Writes data back to the register file.

## Implementation Details
- The processor uses a dictionary to store the instruction memory, with the instruction address as the key and the instruction as the value.
- The program executes the instructions in a sequential manner, with each phase completing before the next one begins.
- The control unit generates control signals based on the instruction type and the current state of the processor.

## Assumptions and Limitations
- The number of inputs and outputs is restricted to 10.
- Inputs are initialized to specific registers as done in Assignment-1.

## Usage
- Run the program with the provided machine code (a sorting algorithm).
- The program will execute the instructions and print the number of clock cycles taken to execute all instructions.

## Team Members
Subham Agarwala (IMT2022110)
Chandrima Nandi (IMT2022062)
