----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:02:34 05/15/2010 
-- Design Name: 
-- Module Name:    PresentEnc - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 

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

entity PresentEnc is
	generic (
			w_2: integer := 2;
			w_4: integer := 4;
			w_5: integer := 5;
			w_32: integer := 32;
			w_64: integer := 64;
			w_80: integer := 80
	);
	port(
		plaintext  : in std_logic_vector(w_64 - 1 downto 0);
		key		  : in std_logic_vector(w_80 - 1 downto 0);
		ciphertext : out std_logic_vector(w_64 - 1 downto 0);		
		start, clk, reset : in std_logic;
		ready : out std_logic		
	);
end PresentEnc;

architecture Behavioral of PresentEnc is

	component Reg is
		generic(width : integer := w_64);
		port(
			input  : in  STD_LOGIC_VECTOR(width - 1 downto 0);
			output : out STD_LOGIC_VECTOR(width - 1 downto 0);
			enable : in  STD_LOGIC;
			clk    : in  STD_LOGIC;
			reset  : in  STD_LOGIC
		);
	end component Reg;
	
	component AsyncMux is
		generic (
			width : integer := 64
	);
	port ( 
		input0 : in  STD_LOGIC_VECTOR(width - 1 downto 0);
		input1 : in  STD_LOGIC_VECTOR(width - 1 downto 0);
		ctrl   : in  STD_LOGIC;
		output : out STD_LOGIC_VECTOR(width - 1 downto 0)
	);
	end component AsyncMux;

	component PresentStateMachine is
		generic (
			w_5 : integer := 5
		);
		port (			
			clk, reset, start : in std_logic;
			ready, cnt_res, ctrl_mux, RegEn: out std_logic;
			num : in std_logic_vector (w_5-1 downto 0)
		);
	end component;

	component slayer is
		generic (
				w_4 : integer := 4
		);
		port (
			input : in std_logic_vector(w_4-1 downto 0);
			output : out std_logic_vector(w_4-1 downto 0)
		);
	end component;

	component pLayer is
		generic(w_64 : integer := 64);
		port(
			input : in std_logic_vector(w_64-1 downto 0);
			output : out std_logic_vector(w_64-1 downto 0)
		);
	end component;

	component keyupd is
		generic(	
			w_5 : integer := 5;
			w_80: integer := 80
		);
		port(
			num : in std_logic_vector(w_5-1 downto 0);
			key : in std_logic_vector(w_80-1 downto 0);			
			keyout : out std_logic_vector(w_80-1 downto 0)
		);
	end component;

	component counter is
		generic (
			w_5 : integer := 5
		);
		port (
			clk, reset, cnt_res : in std_logic;
			num : out std_logic_vector (w_5-1 downto 0)
		);
	end component;
	
	signal keynum : std_logic_vector (w_5-1 downto 0);
	signal toXor, ciph, P, Pout, textToReg : std_logic_vector (w_64-1 downto 0);
	signal keyfout, kupd, keyToReg : std_logic_vector (w_80-1 downto 0);
	signal ready_sig, mux_ctrl,  cnt_res, RegEn : std_logic;
	
	begin
		mux_64: AsyncMux generic map(width => w_64) port map(
			input0 => plaintext, 
			input1 => Pout, 
			ctrl => mux_ctrl, 
			output => textToReg
		);
		regText : Reg generic map(width => w_64) port map(
			input  => textToReg,
			output  => toXor, 
			enable  => RegEn, 
			clk  => clk, 
			reset  => reset
		);
		mux_80: AsyncMux generic map(width => w_80) port map(
			input0 => key, 
			input1 => kupd, 
			ctrl => mux_ctrl, 
			output => keyToReg
		);
		regKey : Reg generic map(width => w_80) port map(
			input  => keyToReg, 
			output  => keyfout, 
			enable  => RegEn, 
			clk  => clk, 
			reset  => reset
		);
		slayers : for N in 15 downto 0 generate 
			s_x: slayer port map(
				input => ciph(4*N+3 downto 4*N), 
				output => P(4*N+3 downto 4*N)
			);
		end generate slayers;
		p1: pLayer port map(
			input => P, 
			output => Pout
		);
		mixer: keyupd port map(
			key => keyfout, 
			num => keynum, 
			keyout => kupd
		);		
		SM: PresentStateMachine port map(
			start => start, 
			reset => reset, 
			ready => ready_sig, 
			cnt_res => cnt_res, 
			ctrl_mux => mux_ctrl,
			clk => clk,
			num => keynum,
			RegEn => RegEn
		);
		count: counter port map( 
			clk => clk, 
			reset => reset, 
			cnt_res => cnt_res, 
			num => keynum
		);	
		ciph <= toXor xor keyfout(79 downto 16);
		ciphertext <= ciph;
		ready <= ready_sig;
end Behavioral;
