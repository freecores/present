----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:58:15 04/02/2011 
-- Design Name: 
-- Module Name:    outputRegister - Behavioral 
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

entity outputRegister is
	generic (
		w_2 : integer := 2;
		w_32: integer := 32;
		w_64: integer := 64
	);
   port(
		rst, clk, rd : in std_logic;
		ctrl : in std_logic_vector(w_2-1 downto 0);
		input : in std_logic_vector(w_64-1 downto 0);
		output : out std_logic_vector(w_32-1 downto 0);
		ready : out std_logic
   );
end outputRegister;

architecture Behavioral of outputRegister is
	signal reg : std_logic_vector(w_64-1 downto 0);
	begin
		process( rst, clk, ctrl, input)
			begin
				if (rst = '1') then 
					output <= (others=>'Z');
				elsif(clk'event and clk = '1') then
					if(ctrl = out_ld_reg) then	
						reg <= input;
						output <= (others=>'Z');
					elsif (ctrl = out_reg_L) then
						output <= reg(w_32-1 downto 0);
					elsif (ctrl = out_reg_H) then
						output <= reg(w_64-1 downto w_32);
					else
						output <= (others=>'Z');
					end if;
				end if;
			end process;
			ready <= rd;
	end Behavioral;

