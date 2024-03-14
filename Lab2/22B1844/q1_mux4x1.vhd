library IEEE;
use IEEE.std_logic_1164.all;

entity mux4x1 is
    port(D: in std_logic_vector (3 downto 0);
         S: in std_logic_vector(1 downto 0);
         Y: out std_logic);
end entity;

architecture behaviour of mux4x1 is

  component AND_Gate is
    port(x1: in std_logic;
         x2: in std_logic;
         y: out std_logic);
  end component;

  component OR_Gate is
    port(x1: in std_logic;
         x2: in std_logic;
         y: out std_logic);
  end component;

  component NOT_Gate is
    port(x: in std_logic;
         y: out std_logic);
  end component;

  signal not_S1, not_S0: std_logic;
  signal temp1, temp2, temp3, temp4, temp5, temp6: std_logic;
  signal term1, term2, term3, term4: std_logic;

  begin

  not1: NOT_Gate port map(S(1), not_S1);
  not2: NOT_Gate port map(S(0), not_S0);
  and1: AND_Gate port map(D(0), not_S1, temp1);
  and2: AND_Gate port map(temp1, not_S0, term1);
  and3: AND_Gate port map(D(1), not_S1, temp2);
  and4: AND_Gate port map(temp2, S(0), term2);
  and5: AND_Gate port map(D(2), S(1), temp3);
  and6: AND_Gate port map(temp3, not_S0, term3);
  and7: AND_Gate port map(D(3), S(1), temp4);
  and8: AND_Gate port map(temp4, S(0), term4);
  or1: OR_Gate port map(term1, term2, temp5);
  or2: OR_Gate port map(term3, term4, temp6);
  or3: OR_Gate port map(temp5, temp6, Y);
  
  end;
