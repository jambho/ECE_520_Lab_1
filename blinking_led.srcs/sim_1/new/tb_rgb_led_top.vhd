----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/14/2026 04:31:34 PM
-- Design Name: 
-- Module Name: tb_rgb_led_top - Behavioral
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

entity tb_rgb_led_top is
    -- Port ();
end tb_rgb_led_top;

architecture Behavioral of tb_rgb_led_top is
component rgb_led_top is
   generic (
    CLK_CYCLES_PER_TOGGLE: natural := 10
   );
    Port ( sys_clk, rst : in STD_LOGIC;
           sw : in std_logic_vector (2 downto 0);
           rgb_out : out std_logic_vector (2 downto 0));
end component;

constant CLK_PERIOD : time := 2ns;
signal sys_clk, rst: STD_LOGIC;
signal sw : STD_LOGIC_VECTOR (2 downto 0) := "000";
signal rgb_out_tb : STD_LOGIC_VECTOR (2 downto 0);

begin
    clk: process
    begin
        sys_clk <= '0';
        wait for CLK_PERIOD/2;
        sys_clk <= '1';
        wait for CLK_PERIOD/2;
    end process;
    
    DUT: rgb_led_top
        generic map(CLK_CYCLES_PER_TOGGLE => 2)
        port map (
            sys_clk => sys_clk,
            rst => rst,
            sw => sw,
            rgb_out => rgb_out_tb
        );
    test:process
    begin
        rst <= '1';
        wait for 4*CLK_PERIOD;
        rst <= '0';
        wait for CLK_PERIOD;
        
        sw <= "001"; --TEST CASE 1
        wait for 8*CLK_PERIOD;
        sw <= "010";
        wait for 4*CLK_PERIOD;
        sw <= "100";
        wait for 4*CLK_PERIOD;       
        
        sw <= "000"; --TEST CASE 2
        wait for 4*CLK_PERIOD;
        sw <= "011";
        wait for 4*CLK_PERIOD;
        sw <= "101";
        wait for 4*CLK_PERIOD;
        sw <= "110";
        wait for 4*CLK_PERIOD;
        sw <= "111";
        wait for 4*CLK_PERIOD;
        
        rst <= '1';
        sw <= "001"; --TEST CASE 3
        wait for 4*CLK_PERIOD;
        sw <= "010";
        wait for 4*CLK_PERIOD;
        sw <= "100";
        wait for 4*CLK_PERIOD;    
        
        rst <= '0'; --TEST CASE 4
        sw <= "000";
        wait until falling_edge(sys_clk);
        wait for 4*CLK_PERIOD;
        
        rst <= '1';
        sw <= "000"; --TEST CASE 5
        wait for 4*CLK_PERIOD;
        sw <= "011";
        wait for 4*CLK_PERIOD;
        sw <= "101";
        wait for 4*CLK_PERIOD;
        sw <= "110";
        wait for 4*CLK_PERIOD;
        sw <= "111";
        wait;
    end process;      
end Behavioral;
