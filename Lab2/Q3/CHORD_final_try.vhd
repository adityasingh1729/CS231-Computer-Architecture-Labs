library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CHORDEncoder2 is
    	port(clk, rst: in std_logic;
             a: in std_logic_vector(7 downto 0);
             data_valid: out std_logic;
             z: out std_logic_vector(7 downto 0));
end entity;

architecture behaviour of CHORDEncoder2 is

  type std_logic_vector_array is array  (natural range <>) of std_logic_vector(7 downto 0);
  signal keys : std_logic_vector_array(0 to 11);

  signal C: integer := 01000011;     -- C
  signal d_flat: std_logic_vector(7 downto 0) := "01100100";     -- d
  signal D: std_logic_vector(7 downto 0) := "01000100";     -- D
  signal e_flat: std_logic_vector(7 downto 0) := "01100101";     -- e   
  signal E: std_logic_vector(7 downto 0) := "01000101";     -- E
  signal F: std_logic_vector(7 downto 0) := "01000110";     -- F
  signal g_flat: std_logic_vector(7 downto 0) := "01100111";     -- g
  signal G: std_logic_vector(7 downto 0) := "01000111";     -- G
  signal a_flat: std_logic_vector(7 downto 0) := "01100001";     -- a
  signal A_note: std_logic_vector(7 downto 0) := "01000001";     -- A
  signal b_flat: std_logic_vector(7 downto 0) := "01100010";     -- b
  signal B: std_logic_vector(7 downto 0) := "01000010";     -- B

  begin
  process(clk)
    begin
    if rising_edge(clk) then
      if a = C then
        report "Yes" severity note;
      else
        report "No" severity note;
      end if;
    end if;
  end process;
end architecture; 
