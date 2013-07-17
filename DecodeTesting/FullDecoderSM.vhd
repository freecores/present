----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:24:13 07/14/2013 
-- Design Name: 
-- Module Name:    FullDecoderSM - Behavioral 
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

entity FullDecoderSM is
	port(
		key_gen_start : out std_logic;
		key_gen_ready : in std_logic;
		decode_start  : out std_logic;
		decode_ready  : in std_logic;
		full_decoder_start :in std_logic;
		full_decoder_ready : out std_logic;
		clk, reset  :in std_logic
	);
end FullDecoderSM;

architecture Behavioral of FullDecoderSM is

	signal state : decode_states;
	signal next_state : decode_states;	

begin

	states : process(state, full_decoder_start, key_gen_ready, decode_ready)
		begin
			case state is
				when NOP =>
					key_gen_start <= '0';
					decode_start <= '0';
					full_decoder_ready <= '0';
					if (full_decoder_start = '1') then
						next_state <= KG_START;
					else
						next_state <= NOP;
					end if;
				when KG_START =>
					key_gen_start <= '1';
					decode_start <= '0';
					full_decoder_ready <= '0';
					if (key_gen_ready = '1') then
						next_state <= DEC_START;
					else
						next_state <= KG_START;
					end if;
				when DEC_START	 =>
					key_gen_start <= '1';
					decode_start <= '1';
					full_decoder_ready <= '0';
					if (decode_ready = '1') then
						next_state <= DEC_READY;
					else
						next_state <= DEC_START;
					end if;
				when DEC_READY =>
					key_gen_start <= '1';
					decode_start <= '1';
					full_decoder_ready <= '1';
					if (full_decoder_start = '1') then
						next_state <= DEC_READY;
					else
						next_state <= NOP;
					end if;
			end case;
		end process states;

	SM : process (clk, reset)
			begin
				if (reset = '1') then
					state <= NOP;				
				elsif (clk'Event and clk = '1') then
					state <= next_state;
				end if;
			end process SM;

end Behavioral;

