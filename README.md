# Serial 2's Complementer Using a Shift Register and Flip-Flop

## Digital Logic Design Mini Project

**Course:** Digital Logic Design  
**Institution:** PES University  
**Project Type:** Verilog HDL / Digital Logic Design  

---

## 1. Project Overview

This project implements a **Serial 2's Complementer** using a shift register and a flip-flop.

The circuit generates the 2's complement of a binary number serially. The input binary number is loaded into a shift register, shifted out one bit at a time, and its 2's complement is shifted back into the register.

Unlike a conventional combinational 2's complement circuit, this design performs the operation sequentially using a simple hardware architecture.

## 2. Objective

- Design a serial 2's complement generator.
- Implement the circuit using a shift register and a flip-flop.
- Understand the role of sequential logic in binary arithmetic.
- Implement the design using Verilog HDL.
- Simulate and verify the functionality using Icarus Verilog.
- Analyze the circuit behavior using waveform simulation.

## 3. Working Principle

The 2's complement of a binary number is obtained by:

1. Starting from the least significant bit (LSB).
2. Copying all bits, including the first encountered `1`.
3. Complementing all subsequent bits.
4. Continuing until the entire binary number has been processed.

### Example

Input:

```text
00001101
```

2's complement:

```text
11110011
```

### Algorithm

The circuit maintains a flip-flop state called `seen_one`.

- Initially, `seen_one = 0`.
- While no `1` has been encountered, the input bits are copied unchanged.
- When the first `1` appears, it is copied and the flip-flop becomes `1`.
- Every subsequent bit is inverted.

The serial input to the shift register is determined by:

```text
serial_in = serial_out XOR seen_one
```

The flip-flop updates according to:

```text
seen_one_next = seen_one OR serial_out
```

## 4. Hardware Architecture

The design consists of:

- **N-bit Shift Register:** Stores the input binary number and shifts it during operation.
- **Flip-Flop:** Stores whether the first `1` has already been encountered.
- **XOR Gate:** Generates the serial input required for the 2's complement operation.
- **Control Signals:** Clock, reset, load, and shift enable.

### Block Diagram Concept

```text
                   +-------------------+
                   |                   |
                   |    Shift Register |
                   |                   |
       Serial In ->| MSB           LSB|----> Serial Out
                   |                   |        |
                   +-------------------+        |
                                               XOR
                                                |
                                         +-------------+
                                         | Flip-Flop  |
                                         |  seen_one   |
                                         +-------------+
                                                |
                                                +---- XOR Control
```

## 5. Boolean Logic

The serial input is:

```text
D = X XOR Q
```

Where:

- `X` = Serial output / current LSB
- `Q` = Flip-flop output (`seen_one`)
- `D` = Serial input to the shift register

The flip-flop state equation is:

```text
Q(next) = Q OR X
```

This ensures that the circuit remembers when the first `1` has been encountered.

## 6. Verilog Implementation

The design is implemented using two modules:

- `first_one_ff`: Detects the first `1` and stores the state.
- `serial_complementer`: Contains the shift register and control logic.

The complete implementation is available in:

```text
src/serial_complementer.v
```

## 7. Simulation

The design is simulated using **Icarus Verilog**.

### Requirements

- Icarus Verilog
- GTKWave (optional, for waveform visualization)

### Compile the Design

```bash
iverilog -g2012 -Wall -o simulation/sim.out src/serial_complementer.v simulation/tb_serial_complementer.v
```

### Run Simulation

```bash
vvp simulation/sim.out
```

### View Waveforms

If waveform generation is enabled in the testbench:

```bash
gtkwave simulation/waveform.vcd
```

## 8. Test Cases

| Input | Expected 2's Complement |
|---|---|
| 00001101 | 11110011 |
| 00000000 | 00000000 |
| 00000001 | 11111111 |
| 11111111 | 00000001 |
| 00000100 | 11111100 |

These test cases verify normal operation, zero input, and boundary cases.

## 9. Applications

Serial 2's complement circuits are useful in:

- Serial arithmetic circuits
- Digital signal processing
- Arithmetic logic units
- Low-cost sequential arithmetic hardware
- Embedded digital systems

## 10. Team Contributions

| Member | Responsibility |
|---|---|
| Member 1 | Introduction, theoretical explanation, and algorithm |
| Member 2 | Circuit design, block diagram, and logic analysis |
| Member 3 | Verilog implementation, simulation, and code verification |
| Member 4 | Testing, results, applications, and conclusion |

## 11. Conclusion

The project demonstrates the implementation of a serial 2's complement generator using a shift register and a flip-flop.

The circuit efficiently performs the operation using sequential logic, reducing the need for a complete combinational complementing network.

Through Verilog implementation and simulation, the project provides practical understanding of shift registers, flip-flops, XOR logic, and sequential digital design.

---

## Repository Structure

```text
dlcd_miniproject/
├── src/
│   └── serial_complementer.v
├── simulation/
│   ├── tb_serial_complementer.v
│   └── waveform.vcd
├── README.md
└── .gitignore
```

