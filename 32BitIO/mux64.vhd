----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:59:34 04/03/2011 
-- Design Name: 
-- Module Name:    mux - Behavioral 
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
use work.kody.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux64 is
	generic (
		w_2 : integer := 2;
		w_32 : integer := 32;
		w_64 : integer := 64
	);
	port(
		i0ctrl : in std_logic_vector (w_2-1 downto 0);
		input0 : in std_logic_vector(w_32-1 downto 0);
		input1 : in std_logic_vector(w_64-1 downto 0);		
		ctrl, clk, reset : in std_logic;
		output : inout std_logic_vector(w_64-1 downto 0)
	);
end mux64;

architecture Behavioral of mux64 is
	
begin
	inne : process (clk, reset)
		begin
			if (reset = '1') then
				output <= (others => '0');
			elsif (clk'Event and clk = '1') then
					if ctrl = '0' then
						if (i0ctrl = in_ld_reg_L ) then 
							output <= output(w_64-1 downto 32) & input0;
						elsif (i0ctrl = in_ld_reg_H) then
							output <= input0 & output(31 downto 0);
						else 
							output <= output;
						end if;						
					else
						output <= input1;
				end if;
			end if;
		end process inne;
end Behavioral;

