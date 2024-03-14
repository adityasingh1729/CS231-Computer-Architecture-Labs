library IEEE;
use IEEE.std_logic_1164.all;

entity decoder4x16 is
    port(a, b, c, d, enable: in std_logic;
         dec: out std_logic_vector(15 downto 0));
end entity;

architecture behaviour of decoder4x16 is

  component decoder2x4 is
    port(D1, D0: in std_logic;
         enable: in std_logic;
         Y: out std_logic_vector (3 downto 0));
  end component;

  signal I: std_logic_vector (3 downto 0);

  begin

  decoder1: decoder2x4 port map(a, b, enable, I);
  decoder2: decoder2x4 port map(c, d, I(0), dec(3 downto 0));
  decoder3: decoder2x4 port map(c, d, I(1), dec(7 downto 4));
  decoder4: decoder2x4 port map(c, d, I(2), dec(11 downto 8));
  decoder5: decoder2x4 port map(c, d, I(3), dec(15 downto 12));
  
end architecture;
