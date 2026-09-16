# ECE520 Lab 1
Jamal Bhola

Led Blinker and RGB Blinker

## Project Abstract

This project utilizes a Zybo Z7-10 and its onboard LEDs to demonstrate basic VHDL. We start by creating a design file that implements a counter and an LED to indicate the rate. The counter counts clock cycles from the board's 125 MHz clock, and every time it reaches its limit the LED flips on or off, making it blink once per second. After that, the blinker is reused inside a top-level design that lets the switches pick which color of the onboard RGB LED blinks.

## Hardware
- Zynq - 7010 Development Board (Zybo Z7-10)
- 1 USB cable
- Windows 11 Computer with software installed (AMD Vivado)


## Prelab Code

### Blinking LED

The blinking_led entity has four ports: sys_clk (125 MHz clock), rst (reset), led_en (enable), and led_out (the LED). It also has a generic called CLK_CYCLES_PER_TOGGLE set to 62,500,000 by default.


On every rising edge of the clock, a counter goes up by 1. When the counter hits CLK_CYCLES_PER_TOGGLE - 1, the LED flips and the counter goes back to 0. If rst is 1 or led_en is 0, the counter and the LED are both cleared to 0. Since 62,500,000 cycles at 125 MHz is 0.5 seconds, the LED is on for half a second and off for half a second, so it blinks once per second.

```vhdl
if rising_edge(sys_clk) then
    if rst = '1' or led_en = '0' then
        led_toggle <= '0';
        counter <= 0;
    elsif led_en = '1' then
        if counter = CLK_CYCLES_PER_TOGGLE - 1 then
            led_toggle <= not led_toggle;
            counter <= 0;
        else
            counter <= counter + 1;
        end if;
    end if;
end if;
led_out <= led_toggle;
```


### Blinking LED Testbench

The testbench tb_blinking_led creates the blinker with CLK_CYCLES_PER_TOGGLE set to 10, so the LED toggles every 10 clock cycles instead of waiting millions of cycles in simulation. A clock process generates a repeating clock signal, and a test process changes rst and led_en to check each case.

- **Test Case 1 – Reset Behavior:** rst = 1 and led_en = 0. The LED stays at 0 and the counter is held at 0.

- **Test Case 2 – Disabled Output:** rst = 0 but led_en = 0. The LED still stays at 0 and the counter stays at 0.

- **Test Case 3 – LED Toggling:** rst = 0 and led_en = 1. The LED toggles once every 10 rising clock edges, and it drops from 1 to 0 when led_en is turned off.

### Blinking LED Hardware Implementation

The Digilent Zybo Z7 master constraints file was added to the project, and the needed lines were uncommented and renamed to match the ports:

| Port      | Board Part | Pin |
|-----------|------------|-----|
| sys_clk | Clock      | K17 |
| led_en  | SW0        | G15 |
| rst     | BTN0       | K18 |
| led_out | LED0       | M14 |

After running synthesis, implementation, and generating the bitstream, the board was programmed through the Hardware Manager. Flipping SW0 up makes LED0 blink once every second.

*(insert photo of board)*


## Post lab Code

### RGB LED

The rgb_led_top entity is the top-level design. It has sys_clk, rst, a 3-bit switch input sw, and a 3-bit output rgb_out (bit 0 = red, bit 1 = green, bit 2 = blue).

Inside, it creates one copy of blinking_led. The blinker is only enabled when exactly one switch is on. The blinking signal is then sent to the color that matches the switch:

| Switch | Output |
|--------|--------|
| SW0 (001) | Red |
| SW1 (010) | Green |
| SW2 (100) | Blue |
| Anything else | LED off |

vhdl
led_en <= '1' when (sw = "001") or (sw = "010") or (sw = "100") else '0';

rgb_out(0) <= led_out when sw = "001" else '0';
rgb_out(1) <= led_out when sw = "010" else '0';
rgb_out(2) <= led_out when sw = "100" else '0';


For the board, the constraints file maps rst to BTN0, sw to SW0–SW2, and rgb_out to the red, green, and blue pins of the onboard RGB LED.

### RGB LED Testbench

The testbench tb_rgb_led_top sets CLK_CYCLES_PER_TOGGLE to 2 so the blinking shows up quickly in the waveform. It runs five test cases:

- **Test Case 1 – Single switch selection:** Reset is off and sw is set to 001, 010, then 100. Only red, green, then blue blink, one at a time.

- **Test Case 2 – Invalid switch combos:** Reset is off and sw is set to 000, 011, 101, 110, and 111. All RGB outputs stay at 0.

- **Test Case 3 – Reset with valid switches:** Reset is on while sw goes through 001, 010, and 100. All outputs stay at 0 because reset overrides the switches.

- **Test Case 4 – No switches after reset:** Reset is released with sw = 000. The outputs stay at 0 since nothing is selected.

- **Test Case 5 – Reset with invalid combos:** Reset is on while sw goes through 000, 011, 101, 110, and 111. All outputs stay at 0.

![All Test Cases on One Waveform](figures\ECE_520_Testbench_Waveforms.png)
## Overview

In this lab, a simple counter-based LED blinker was written in VHDL, tested in simulation, and programmed onto the Zybo Z7-10. Using a generic for the toggle count made it easy to shrink the count for fast simulations and use the full count on the real board. The blinker was then reused inside a top-level design that uses the switches to choose which color of the RGB LED blinks, turning the LED off when no switch or more than one switch is on. Both designs worked in simulation and on the board.