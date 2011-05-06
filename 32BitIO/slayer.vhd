----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:48:15 05/13/2010 
-- Design Name: 
-- Module Name:    permutation - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity slayer is
	generic (
		w_4 : integer := 4
	);
	port (
		input : in std_logic_vector(w_4-1 downto 0);
		output : out std_logic_vector(w_4-1 downto 0)
	);
end slayer;

architecture Behavioral of slayer is

	begin
		output <= x"C" when input = x"0" else
					 x"5" when input = x"1" else
					 x"6" when input = x"2" else
					 x"B" when input = x"3" else
					 x"9" when input = x"4" else
					 x"0" when input = x"5" else 
					 x"A" when input = x"6" else
					 x"D" when input = x"7" else
					 x"3" when input = x"8" else
					 x"E" when input = x"9" else 
					 x"F" when input = x"A" else
					 x"8" when input = x"B" else 
					 x"4" when input = x"C" else
					 x"7" when input = x"D" else 
					 x"1" when input = x"E" else
					 x"2" when input = x"F" else
					 "ZZZZ";
	end Behavioral;