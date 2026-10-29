# 1011 Sequence Detector using Mealy FSM

## Overview
This project implements a serial binary sequence detector using Verilog HDL and a Mealy Finite State Machine (FSM). The circuit detects the input pattern `1011` and produces a HIGH output when the complete sequence is recognized.

## Features
- Mealy FSM-based sequence detection.
- Detects the binary sequence `1011`.
- Supports overlapping sequence detection.
- Uses clock and asynchronous active-low reset.
- Includes a Verilog testbench for simulation.
- Generates waveform data for signal analysis.

## Tools and Technologies
- **Hardware Description Language:** Verilog HDL
- **Simulator:** Coddy Verilog Playground
- **Concepts:** FSM, sequential logic, state transitions, and digital circuit simulation.

## Working Principle
The FSM processes one input bit (`din`) at a time and moves between states according to the received bits.

The states represent partial matches of the target sequence:
- `S0`: No matching bits
- `S1`: Detected `1`
- `S10`: Detected `10`
- `S101`: Detected `101`

When the circuit receives the final `1` after `101`, the output `detected` becomes HIGH, indicating that `1011` has been recognized.

## Example
**Input sequence:** `1 0 1 1 0 1 1`

**Expected detection:** Two detections of the sequence `1011`.

## Simulation Results
The design can be simulated using the included testbench. The output signal `detected` is expected to become HIGH when the input completes the target sequence. The generated waveform can be used to observe the clock, reset, input, and detection output.

## Files
- `main.v` — Contains the sequence detector design and testbench.

## Learning Outcomes
- Understanding Mealy FSM design.
- Implementing sequence detection using Verilog.
- Learning state transitions and overlapping pattern detection.
- Writing testbenches and analyzing simulation waveforms.

## Author
Zaima Siddiqui
<img width="752" height="475" alt="detector_output" src="https://github.com/user-attachments/assets/f27d6e27-3595-47ec-897d-92f0cb0eea43" />
<img width="761" height="535" alt="detector_waveform" src="https://github.com/user-attachments/assets/97022116-e9bc-4809-9e94-6ad480532ef3" />



## License
For educational and learning purposes.
