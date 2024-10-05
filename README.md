# Flossy_Fresher_Than_Before

## Overview

Flossy Fresher Than Before is a firmware project developped for the STM8 microcontroller, designed to enhance the existing FlossyFresh product. This project includes significant improvements, such as better PCB quality and full motor range operation (5V).

The device features multiple operational states:
- **Sleep**: Low power consumption mode, awaiting wake-up.
- **Idle**: Device is powered on with LEDs active but not performing any tasks.
- **Full Speed**: The pump operates at maximum speed.
- **Low Speed**: The pump operates at a reduced speed.
- **Pulse**: The pump operates in a controlled pulsing mode.

The current implementation allows for pump operation and system control, with ongoing optimizations and enhancements planned for the future. Note that the firmware can only be programmed when the device is in sleep mode.

## Getting Started

To get started with this project, follow these steps:

1. **Clone the Repository**: You can clone the repository using the following command:
   \`\`\`bash
   git clone https://github.com/Mickael-Urbino/Fresher_than_Before.git
   \`\`\`

2. **Programming Software**: Use STVD (ST Visual Develop) to program the STM8 microcontroller. 

3. **Flashing Software**: Use STVP (ST Visual Programmer) to flash the STM8 microcontroller.

4. **Programming Interface**: The programming pins are connected using Segger 6-pin pogo pins, utilizing the SWIM interface.

## License

This project is licensed under the Creative Commons Non-Commercial License. You may copy, modify, and share the software, but not for commercial purposes. See the [LICENSE](LICENSE) file for details.
