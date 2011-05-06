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

entity PresentStateMachine is
	generic (
			w_2 : integer := 2;
			w_4 : integer := 4;
			w_5 : integer := 5;
			w_32: integer := 32;
			w_64: integer := 64;
			w_80: integer := 80
	);
	port (
		clk, reset : in std_logic;
		info : in std_logic_vector (w_2-1 downto 0);
		ctrl : in std_logic_vector (w_4-1 downto 0);
		key_ctrl: out std_logic_vector (w_2-1 downto 0);
		plain_ctrl: out std_logic_vector (w_2-1 downto 0);
		outReg : out std_logic_vector (w_2-1 downto 0);
		ready, cnt_res, ctrl_mux64, ctrl_mux80: out std_logic
	);
end PresentStateMachine;

architecture Behavioral of PresentStateMachine is
	
	signal stan : stany;
	signal stan_nast : stany;	
	
	begin
		States : process(stan, ctrl, info)
			begin
				stan_nast<= stan;
				case stan is
					when NOP =>
						ready <= '0';
						outReg <= out_reg_Z;
						cnt_res <= '0';
						ctrl_mux64 <= '0';
						ctrl_mux80 <= '0';
						if (ctrl = crdk1) then 
							key_ctrl <= in_ld_reg_L;
							stan_nast <= RDK1;
						else 
							stan_nast <= NOP;
						end if;
					when RDK1 =>
						if (ctrl = crdk2) then
							key_ctrl <= in_ld_reg_H;
							stan_nast <= RDK2;
						elsif (ctrl = crdk1) then
							key_ctrl <= in_ld_reg_L;
						else
							stan_nast <= NOP;
						end if;
					when RDK2 =>
						if (ctrl = crdk3) then
							key_ctrl <= in_ld_reg_HH;
							stan_nast <= RDK3;
						elsif (ctrl = crdk2) then
							key_ctrl <= in_ld_reg_H;
						else
							stan_nast <= NOP;
						end if;
					when RDK3 =>
						if (ctrl = crdt1) then
							key_ctrl <= in_reg_Z;
							plain_ctrl <= in_ld_reg_L;
							stan_nast <= RDT1;
						elsif (ctrl = crdk3) then 
							key_ctrl <= in_ld_reg_HH;
						else
							stan_nast <= NOP;
						end if;
					when RDT1 =>
						if (ctrl = crdt2) then
							plain_ctrl <= in_ld_reg_H;
							stan_nast <= RDT2;							
						elsif (ctrl = crdt1) then
							plain_ctrl <= in_ld_reg_L;
						else 
							stan_nast <= NOP;
						end if;
					when RDT2 =>
						if (ctrl = ccod) then
							plain_ctrl <= in_reg_Z;
							stan_nast <= COD;		
							cnt_res <= '1';
						elsif (ctrl = crdt2) then
							plain_ctrl <= in_ld_reg_H;
						else 
							stan_nast <= NOP;
						end if;
					when COD =>
						if (ctrl = ccod) then							
							if (info = "00") then
								stan_nast <= CTO1;
								outReg <= out_ld_reg;
								ready <= '1';
								cnt_res <= '0';
								ready <= '1';																
							elsif (info = "01") then
								ctrl_mux64 <= '1';
								ctrl_mux80 <= '1';
							end if;
						else
							stan_nast <= NOP;
						end if;						
					when CTO1 =>
						if (ctrl = ccto2) then
							stan_nast <= CTO2;
							outReg <= out_reg_L;
						elsif ((ctrl = ccto1) or (ctrl = ccod)) then
							outReg <= out_reg_L;
						else 
							stan_nast <= NOP;
						end if;
					when CTO2 =>
						if (ctrl = ccto2) then
							stan_nast <= CTO2;
							outReg <= out_reg_H;
						else 
							stan_nast <= NOP;
						end if;
				end case;
		end process States;
		
		inne : process (clk, reset)
			begin
				if (reset = '1') then
					stan <= NOP;				
				elsif (clk'Event and clk = '1') then
					stan <= stan_nast;
				end if;
			end process inne;

	end Behavioral;

