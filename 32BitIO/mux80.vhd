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

entity mux80 is
	generic (
		w_2 : integer := 2;
		w_32 : integer := 32;
		w_80 : integer := 80
	);
	port(
		i0ctrl : in std_logic_vector (w_2-1 downto 0);
		input0 : in std_logic_vector(w_32-1 downto 0);
		input1 : in std_logic_vector(w_80-1 downto 0);		
		output : inout std_logic_vector(w_80-1 downto 0);
		ctrl, clk, reset : in std_logic		
	);
end mux80;

architecture Behavioral of mux80 is
	
begin
	inne : process (clk, reset)
		begin
			if (reset = '1') then
				output <= (others => '0');
			elsif (clk'Event and clk = '1') then
					if ctrl = '0' then
						if (i0ctrl = in_ld_reg_L ) then 
							output <= output(80-1 downto 32) & input0;
						elsif (i0ctrl = in_ld_reg_H) then
							output <= output(79 downto 64) & input0 & output(31 downto 0);
						elsif (i0ctrl = in_ld_reg_HH) then
							output <= input0(15 downto 0) & output(63 downto 0);
						else 
							output <= output;
						end if;						
					else
						output <= input1;
				end if;
			end if;
		end process inne;
end Behavioral;

