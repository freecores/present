----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:24:35 06/24/2013 
-- Design Name: 
-- Module Name:    AsyncMux - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AsyncMux is
	generic (
		width : integer := 64
	);
	port ( 
		input0 : in  STD_LOGIC_VECTOR(width - 1 downto 0);
		input1 : in  STD_LOGIC_VECTOR(width - 1 downto 0);
		ctrl   : in  STD_LOGIC;
		output : out STD_LOGIC_VECTOR(width - 1 downto 0)
	);
end AsyncMux;

architecture Behavioral of AsyncMux is

begin
	output <= input0 when (ctrl = '0') else
		input1;
end Behavioral;

