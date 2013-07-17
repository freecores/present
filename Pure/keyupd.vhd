----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:45:36 05/13/2010 
-- Design Name: 
-- Module Name:    keyupd - Behavioral 
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

entity keyupd is
	generic(
		w_80: integer := 80;
		w_5 : integer := 5;
		w_4 : integer := 4);
	port(
		key : in std_logic_vector(w_80-1 downto 0);
		num : in std_logic_vector(w_5-1 downto 0);
		keyout : out std_logic_vector(w_80-1 downto 0)
	);
end keyupd;

architecture Behavioral of keyupd is

	component slayer is
		generic(w_4: integer := 4);
		port(
			input : in std_logic_vector(w_4-1 downto 0);
			output : out std_logic_vector(w_4-1 downto 0)
		);
	end component;

	signal changed : std_logic_vector(w_4-1 downto 0);
	signal changin : std_logic_vector(w_4-1 downto 0);
	signal keytemp : std_logic_vector(w_80-1 downto 0);

	begin
		s1: slayer port map(input => changin, output => changed);
		changin <= keytemp(79 downto 76);
		keytemp <= key(18 downto 0) & key(79 downto 19);
		keyout(79 downto 76)<= changed;
		keyout(75 downto 20) <= keytemp(75 downto 20);
		keyout(19 downto 15)<= keytemp(19 downto 15) xor num;
		keyout(14 downto 0) <= keytemp(14 downto 0);
	end Behavioral;