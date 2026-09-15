----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/14/2026 02:31:02 PM
-- Design Name: 
-- Module Name: rgb_led_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rgb_led_top is
    generic (
        CLK_CYCLES_PER_TOGGLE: natural := 62500000
    );
    Port (
        sys_clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        sw : in STD_LOGIC_VECTOR(2 downto 0);
        rgb_out : out STD_LOGIC_VECTOR(2 downto 0)
     );
end rgb_led_top;



architecture Behavioral of rgb_led_top is

signal led_en: STD_LOGIC;
signal led_out: STD_LOGIC;

component blinking_led is 
    generic (CLK_CYCLES_PER_TOGGLE: natural := 62500000);
    port ( sys_clk, rst, led_en : in STD_LOGIC;
           led_out : out STD_LOGIC := '0');
end component;

begin
led_blinking_unit: blinking_led
    generic map(CLK_CYCLES_PER_TOGGLE => CLK_CYCLES_PER_TOGGLE)
    port map(
        sys_clk => sys_clk,
        rst => rst,
        led_en =>led_en,
        led_out => led_out     
    );
    
led_en <= '1' when (sw ="001") or (sw="010") or (sw="100") else '0';

rgb_out(0) <= led_out when sw = "001" else '0';
rgb_out(1) <= led_out when sw = "010" else '0';
rgb_out(2) <= led_out when sw = "100" else '0';
end Behavioral;
