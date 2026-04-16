# I2C Communication Protocol Implementation

This repository contains a comprehensive implementation of the Inter-Integrated Circuit (I2C) communication protocol using Verilog. The implementation includes a Master module, a Slave module, and a testbench to verify the communication between them.

## Features

- **I2C Master Module**: Generates START and STOP conditions, handles clock stretching, and manages data transfer.
- **I2C Slave Module**: Responds to the master's address, handles read and write operations, and supports clock stretching.
- **Testbench**: Simulates the I2C communication with various test scenarios.

## File Structure

```
I2C-Communication-Protocol/
├── i2c_master.v          # I2C Master module
├── i2c_slave.v           # I2C Slave module
├── i2c_testbench.v       # Testbench for verification
└── README.md             # Project documentation
```

## Modules

### `i2c_master.v`

The I2C master module is responsible for initiating and controlling the communication on the I2C bus. It generates the necessary control signals (START, STOP, ACK/NACK) and manages the data transfer.

**Key Features:**
- Generates START and STOP conditions.
- Handles clock stretching from the slave.
- Supports both 7-bit and 10-bit addressing (though 7-bit is primarily tested).
- Manages data transmission and reception.

### `i2c_slave.v`

The I2C slave module responds to the master's address and performs data transfer operations. It can act as a receiver (data from master to slave) or a transmitter (data from slave to master).

**Key Features:**
- Responds to a configurable 7-bit slave address.
- Supports both write and read operations.
- Implements clock stretching to synchronize with the master.
- Handles data buffering for transmission and reception.

### `i2c_testbench.v`

The testbench verifies the functionality of the I2C master and slave modules. It simulates various communication scenarios to ensure the protocol is implemented correctly.

**Test Scenarios:**
1. **Write Operation**: Master writes data to the slave.
2. **Read Operation**: Master reads data from the slave.
3. **Combined Operation**: Master writes data and then reads it back to verify.

## Simulation Results

The simulation results demonstrate successful I2C communication between the master and slave modules. The waveforms show the correct generation of START/STOP conditions, address transmission, data transfer, and ACK/NACK responses.

### Waveform Analysis

**1. Write Operation:**
- Master sends START condition.
- Master sends slave address with write bit.
- Slave acknowledges the address.
- Master sends data bytes.
- Slave acknowledges each data byte.
- Master sends STOP condition.

**2. Read Operation:**
- Master sends START condition.
- Master sends slave address with read bit.
- Slave acknowledges the address.
- Slave sends data bytes.
- Master sends NACK after the last byte.
- Master sends STOP condition.

## Usage

To simulate the I2C communication, you can use any standard Verilog simulator (e.g., ModelSim, Vivado Simulator, Icarus Verilog).

### Simulation Steps

1. **Compile the Verilog files**:
   ```bash
   vlog i2c_master.v i2c_slave.v i2c_testbench.v
   ```

2. **Run the simulation**:
   ```bash
   vsim i2c_testbench
   ```

3. **View the waveforms**:
   - Add `scl`, `sda`, `start`, `stop`, `ack`, `nack`, `data_out`, `data_in`, and other relevant signals to the waveform viewer.
   - Run the simulation for the desired duration (e.g., 1000 ns).

## Customization

You can customize the I2C communication by modifying the parameters in the Verilog modules:

- **`i2c_master.v`**:
  - `DATA_WIDTH`: Change the data width (default: 8 bits).
  - `ADDR_WIDTH`: Change the address width (default: 7 bits).
  - `CLK_FREQ`: Change the clock frequency.
  - `I2C_SPEED`: Change the I2C bus speed (e.g., 100kHz, 400kHz).

- **`i2c_slave.v`**:
  - `DATA_WIDTH`: Change the data width (default: 8 bits).
  - `SLAVE_ADDR`: Change the slave address (default: 7'b1010101).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.
