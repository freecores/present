----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:17:10 04/02/2011 
-- Design Name: 
-- Module Name:    PresentStateMachine - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use work.kody.ALL;

entity PresentDecStateMachine is
	generic (
		w_5 : integer := 5
	);
	port (
		clk, reset, start : in std_logic;
		ready, cnt_res, ctrl_mux, RegEn: out std_logic;
		num : in std_logic_vector (w_5-1 downto 0)
	);
end PresentDecStateMachine;

architecture Behavioral of PresentDecStateMachine is
	
	signal state : stany;
	signal next_state : stany;	
	
	begin
		States : process(state, start, num)
			begin
				case state is
					when NOP =>
						ready <= '0';
						cnt_res <= '0';
						ctrl_mux <= '0';
						if (start = '1') then 
							RegEn <= '1';
							next_state <= SM_START;
						else 
							RegEn <= '0';
							next_state <= NOP;
						end if;
					when SM_START =>
						ready <= '0';
						cnt_res <= '1';
						if (start = '1') then
							if (num = "11111") then
								RegEn <= '1';
								ctrl_mux <= '1';
								next_state <= SM_START;
							elsif (num = "00000") then
								RegEn <= '0';
								ctrl_mux <= '1';
								next_state <= SM_READY;
							else
								RegEn <= '1';
								ctrl_mux <= '1';
								next_state <= SM_START;
							end if;
						else
							RegEn <= '0';
							ctrl_mux <= '0';
							next_state <= NOP;
						end if;
					when SM_READY =>
						cnt_res <= '0';
						RegEn <= '0';
						ready <= '1';
						if (start = '1') then
							ctrl_mux <= '1';
							next_state <= SM_READY;
						else
							ctrl_mux <= '0';
							next_state <= NOP;
						end if;
				end case;
		end process States;
		
		SM : process (clk, reset)
			begin
				if (reset = '1') then
					state <= NOP;				
				elsif (clk'Event and clk = '1') then
					state <= next_state;
				end if;
			end process SM;

	end Behavioral;

