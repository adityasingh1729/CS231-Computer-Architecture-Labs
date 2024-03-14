library IEEE;
use IEEE.std_logic_1164.all;

entity decoder2x4 is
    port(D1, D0: in std_logic;
         enable: in std_logic;
         Y: out std_logic_vector (3 downto 0));
end entity;

architecture behaviour of decoder2x4 is

  component AND_Gate is
    port(x1: in std_logic;
         x2: in std_logic;
         y: out std_logic);
  end component;

  component NOT_Gate is
    port(x: in std_logic;
         y: out std_logic);
  end component;

  signal not_D1, not_D0: std_logic;
  signal temp0, temp1, temp2, temp3: std_logic;
  begin

  not1: NOT_Gate port map(D1, not_D1);
  not2: NOT_Gate port map(D0, not_D0);
  and0: AND_Gate port map(not_D1, not_D0, temp0);
  and_0: AND_Gate port map(temp0, enable, Y(0));
  and1: AND_Gate port map(not_D1, D0, temp1);
  and_1: AND_Gate port map(temp1, enable, Y(1));
  and2: AND_Gate port map(D1, not_D0, temp2);
  and_2: AND_Gate port map(temp2, enable, Y(2));
  and3: AND_Gate port map(D1, D0, temp3);
  and_3: AND_Gate port map(temp3, enable, Y(3));

  end;
