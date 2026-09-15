----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2026 12:12:56 AM
-- Design Name: 
-- Module Name: blinking_led - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity blinking_led is

   generic (
    CLK_CYCLES_PER_TOGGLE: natural := 62500000
   );
   
  Port (
    sys_clk : in STD_LOGIC;
    rst: in STD_LOGIC;
    led_en : in STD_LOGIC;
    led_out : out STD_LOGIC := '0'
   );

end blinking_led;

architecture Behavioral of blinking_led is

signal counter : integer := 0;
signal led_toggle : std_logic := '0';

begin
    process(sys_clk)
    begin
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
    end process;
end Behavioral;
