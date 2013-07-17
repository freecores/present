----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:14:34 07/14/2013 
-- Design Name: 
-- Module Name:    PresentFullDecoder - Behavioral 
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

entity PresentFullDecoder is
	generic (
			w_2: integer := 2;
			w_4: integer := 4;
			w_5: integer := 5;
			w_32: integer := 32;
			w_64: integer := 64;
			w_80: integer := 80
	);
	port(
		ciphertext : in std_logic_vector(w_64 - 1 downto 0);
		key		  : in std_logic_vector(w_80 - 1 downto 0);
		plaintext  : out std_logic_vector(w_64 - 1 downto 0);
		start, clk, reset : in std_logic;
		ready : out std_logic		
	);
end PresentFullDecoder;

architecture Behavioral of PresentFullDecoder is

component PresentEncKeyGen is
	generic (
			w_2: integer := 2;
			w_4: integer := 4;
			w_5: integer := 5;
			w_80: integer := 80
	);
	port(
		key		: in std_logic_vector(w_80 - 1 downto 0);
		key_end	: out std_logic_vector(w_80 - 1 downto 0);		
		start, clk, reset : in std_logic;
		ready : out std_logic		
	);
end component PresentEncKeyGen;

component PresentDec is
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
end component PresentDec;

component FullDecoderSM is
	port(
		key_gen_start : out std_logic;
		key_gen_ready : in std_logic;
		decode_start  : out std_logic;
		decode_ready  : in std_logic;
		full_decoder_start :in std_logic;
		full_decoder_ready : out std_logic;
		clk, reset  :in std_logic
	);
end component FullDecoderSM;

signal key_gen_output : std_logic_vector(w_80 - 1 downto 0);

signal key_gen_start : std_logic;
signal key_gen_ready : std_logic;

signal decode_start  : std_logic;
signal decode_ready  : std_logic;

begin

	keyGen : PresentEncKeyGen 
		port map(
			key 		=> key,
			key_end	=> key_gen_output,
			start		=> key_gen_start,
			clk		=> clk,
			reset		=> reset,
			ready		=> key_gen_ready
	);

	decoder : PresentDec
		port map(
			plaintext	=> ciphertext,
			key			=> key_gen_output,
			ciphertext	=> plaintext,
			start			=> decode_start,
			clk			=> clk,
			reset			=> reset,
			ready 		=> decode_ready
	);

	SM : FullDecoderSM
		port map(
			key_gen_start => key_gen_start,
			key_gen_ready => key_gen_ready,
			decode_start  => decode_start,
			decode_ready  => decode_ready,
			full_decoder_start => start,
			full_decoder_ready => ready,
			clk => clk,
			reset => reset
	);

end Behavioral;
--- TODO -- Modyfikacja SM w zwi¹zku ze start i licznikiem (jak w czasie liczenia start = 0!!!)
