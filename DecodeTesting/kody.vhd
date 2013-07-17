--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 


library IEEE;
use IEEE.STD_LOGIC_1164.all;
package kody is
	-- type for PresentStateMachine to control the datapath & circuit -- 
	type stany is (NOP, SM_START, SM_READY);
	type decode_states is (NOP, KG_START, DEC_START, DEC_READY);
	type stany_comm is (NOP, READ_DATA_KEY, DECODE_READ_KEY, MOVE_KEY, TEMP_STATE, TEMP2_STATE, TEMP_OUT,
								NOP_FOR_KEY, READ_DATA_TEXT, DECODE_READ_TEXT, MOVE_TEXT,
								PRESENT_ENCODE, WRITE_OUT, MOVE_OUT);
	-- constant as control command from input --
	constant cnop	: std_logic_vector(3 downto 0) := "0000"; --0   no operations
	constant cdec	: std_logic_vector(3 downto 0) := "0001"; --1   decode text
	constant crdk1	: std_logic_vector(3 downto 0) := "0010"; --2   read key part 1
	constant crdk2	: std_logic_vector(3 downto 0) := "0011"; --3   read key part 2
	constant crdk3	: std_logic_vector(3 downto 0) := "0100"; --4   read key part 3
	constant cmkd	: std_logic_vector(3 downto 0) := "0101"; --5   make decrypt key
	constant ccod	: std_logic_vector(3 downto 0) := "0110"; --6   code text
	constant crdt1	: std_logic_vector(3 downto 0) := "0111"; --7   read text part 1
	constant crdt2	: std_logic_vector(3 downto 0) := "1000"; --8   read text part 2
	constant ccto1  : std_logic_vector(3 downto 0) := "1001"; --9  ciphertext output part 1 (LSW)
	constant ccto2  : std_logic_vector(3 downto 0) := "1010"; --A ciphertext output part 2 (MSW)
	-- For input registers (early version, now for mux's)  --
	constant in_ld_reg_L : std_logic_vector(1 downto 0) := "00"; -- Load low part of the register (64 & 80 bit)
	constant in_ld_reg_H : std_logic_vector(1 downto 0) := "01"; -- Load high part of the register (64 & 80 bit)
	constant in_ld_reg_HH : std_logic_vector(1 downto 0) := "10"; -- Load highest part of the register (80 bit only)
	constant in_reg_Z : std_logic_vector(1 downto 0) := "11"; -- High impedance on the line (unused - in this design only for block input)
	-- For output register --
	constant out_ld_reg : std_logic_vector(1 downto 0) := "00"; -- Load the output register
	constant out_reg_L : std_logic_vector(1 downto 0) := "01"; -- send low part of the register to the output
	constant out_reg_H : std_logic_vector(1 downto 0) := "10"; -- senf high part of the register to the output
	constant out_reg_Z : std_logic_vector(1 downto 0) := "11"; -- High impedance on the line (unused - in this design only for block input)
end kody;