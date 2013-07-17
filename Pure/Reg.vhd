----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:41:41 06/24/2013 
-- Design Name: 
-- Module Name:    Reg - Behavioral 
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

entity Reg is
	generic(width : integer := 64);
	port(
		input  : in  STD_LOGIC_VECTOR(width - 1 downto 0);
		output : out STD_LOGIC_VECTOR(width - 1 downto 0);
		enable : in  STD_LOGIC;
		clk    : in  STD_LOGIC;
		reset  : in  STD_LOGIC
	);
end Reg;

architecture Behavioral of Reg is

signal reg : STD_LOGIC_VECTOR(width - 1 downto 0);

begin
	clock : process(clk, reset)
		begin
			if (reset = '1') then
				reg <= (others => '0');
			elsif (clk = '1' and clk'Event) then
				if (enable = '1') then
					reg <= input;
				end if;
			end if;				
		end process clock;
	output <= reg;
end Behavioral;

