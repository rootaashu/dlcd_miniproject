# Serial 2's Complementer Using Verilog HDL

A digital logic design project that implements a **Serial 2's Complementer using a Shift Register and a D Flip-Flop**. The design generates the 2's complement of a binary number serially, processing one bit per clock cycle.

## Project Overview

The Serial 2's Complementer is a sequential digital circuit that computes the 2's complement of a binary number using a shift register and a state flip-flop.

Unlike a parallel 2's complementer, which processes all bits simultaneously, this design processes the input serially. The original binary number is shifted out from the least significant bit (LSB), while the corresponding 2's complement bits are shifted back into the register.

The circuit uses a simple state-tracking mechanism to identify the first occurrence of `1` and determine when subsequent bits must be complemented.

## Objectives

- Design a serial 2's complementer using Verilog HDL.
- Implement an N-bit shift register for serial data processing.
- Use a D flip-flop to track the occurrence of the first `1`.
- Generate the 2's complement using XOR and OR logic.
- Simulate and verify the circuit using Icarus Verilog.
- Analyze the circuit operation through timing waveforms.

## Architecture

The design consists of the following components:

1. **N-bit Shift Register:** Stores the input binary number and shifts data one bit per clock cycle.
2. **D Flip-Flop:** Maintains the state indicating whether the first `1` has been encountered.
3. **XOR Gate:** Determines whether the current bit should be copied or inverted.
4. **Control Signals:** Manage parallel loading, shifting, and resetting.

### Block Diagram

```text
          Parallel Input
                |
                v
        +------------------+
        |  N-bit Shift     |
        |    Register      |
        +------------------+
                |
                v
         Serial Output
             (LSB)
                |
          +-----+------+
          |            |
          v            v
        XOR Gate    D Flip-Flop
          |            |
          |       First 1 Detection
          |            |
          +-----+------+
                |
                v
          Serial Input
                |
                v
          Shift Register
```

## Working Principle

The circuit follows the standard serial 2's complement algorithm:

1. Start processing the binary number from the LSB.
2. Copy each bit until the first `1` is encountered.
3. Copy the first `1` itself.
4. Complement all subsequent bits.
5. Shift the generated bits back into the register.
6. After N clock cycles, the shift register contains the 2's complement.

### Boolean Expressions

Let:

- `x` = Current serial input bit.
- `s` = State indicating whether the first `1` has appeared.
- `y` = Generated serial complement bit.

The output equation is:

```text
y = x XOR s
```

The next-state equation is:

```text
s(next) = s OR x
```

Initially, the state is reset to `0`.

Once the first `1` is detected, the state remains `1` until the next load or reset operation.

## Example

Consider the 8-bit binary input:

```text
Original Number:  10110000
2's Complement:   01010000
```

The bits are processed from right to left (LSB first).

| Clock Cycle | Bit Shifted Out | State | Bit Shifted In |
|---|---|---|---|
| 1 | 0 | 0 | 0 |
| 2 | 0 | 0 | 0 |
| 3 | 0 | 0 | 0 |
| 4 | 0 | 0 | 0 |
| 5 | 1 | 1 | 1 |
| 6 | 1 | 1 | 0 |
| 7 | 0 | 1 | 1 |
| 8 | 1 | 1 | 0 |

Final register output:

```text
01010000
```

## Technologies Used

- **Hardware Description Language:** Verilog HDL
- **Simulator:** Icarus Verilog
- **Waveform Viewer:** GTKWave
- **Operating System:** Linux (EndeavourOS)
- **Version Control:** Git and GitHub

## Project Structure

```text
dlcd_miniproject/
│
├── README.md
│
├── src/
│   └── serial_complementer.v
│
├── simulation/
│   ├── tb_serial_complementer.v
│   ├── sim.out
│   ├── output.txt
│   └── waveform.vcd
│
├── diagrams/
│   └── architecture.png
│
└── screenshots/
    └── simulation_output.png
```

## Installation and Setup

Install the required tools on Arch Linux / EndeavourOS:

```bash
sudo pacman -S iverilog gtkwave git
```

Verify the installation:

```bash
iverilog -V
gtkwave --version
```

## Compilation and Simulation

Navigate to the project directory:

```bash
cd ~/Documents/dlcd_miniproject
```

Compile the Verilog source and testbench:

```bash
iverilog -g2012 -o simulation/sim.out \
src/serial_complementer.v \
simulation/tb_serial_complementer.v
```

Run the simulation:

```bash
vvp simulation/sim.out
```

## Waveform Analysis

To generate and inspect the simulation waveform, include the following statements inside the testbench:

```verilog
$dumpfile("simulation/waveform.vcd");
$dumpvars(0, tb_serial_complementer);
```

Run the simulation and open the waveform:

```bash
vvp simulation/sim.out
gtkwave simulation/waveform.vcd
```

Important signals to observe:

- `clk` – Clock signal.
- `rst_n` – Active-low reset.
- `load` – Parallel loading control.
- `shift_en` – Shift enable.
- `shift_reg` – Internal shift register.
- `serial_out` – Serial output bit.
- `seen_one` – Flip-flop state.
- `serial_in` – Generated complement bit.

## Test Cases

The testbench verifies the following inputs:

| Input | Expected 2's Complement |
|---|---|
| `10110000` | `01010000` |
| `00001101` | `11110011` |
| `00000000` | `00000000` |
| `11111111` | `00000001` |
| `00000001` | `11111111` |

The design is considered successful when the final contents of the shift register match the expected 2's complement for every test case.

## Features

- Parameterized N-bit shift register.
- Serial processing of binary input.
- D flip-flop-based state tracking.
- XOR-based complement generation.
- Parallel loading and controlled shifting.
- Asynchronous active-low reset.
- Verilog testbench-based functional verification.
- Waveform analysis using GTKWave.

## Applications

Serial 2's complementers are useful in:

- Sequential arithmetic circuits.
- Digital arithmetic processing.
- Serial data processing systems.
- Arithmetic units and digital computation architectures.
- Hardware designs where reduced hardware complexity is preferred over parallel processing speed.

## Team Contributions

This project is developed as a four-member academic mini-project.

| Member | Responsibility |
|---|---|
| Member 1 | Introduction, theory and working principle |
| Member 2 | Circuit design and logic analysis |
| Member 3 | Verilog coding, simulation and implementation |
| Member 4 | Testing, results and applications |

## Future Improvements

- Extend the design to support different input widths.
- Implement a dedicated controller using an FSM.
- Add a `done` signal to indicate completion.
- Explore FPGA implementation.
- Compare serial and parallel 2's complementer architectures.

---

*Developed as part of a Digital Logic Design mini-project.*  
