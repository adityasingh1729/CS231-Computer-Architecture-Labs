library IEEE;
use IEEE.std_logic_1164.all;

entity or_tb is
end entity;

architecture tb of or_tb is

  signal i1, i2: std_logic;
  signal g: std_logic;

  component OR_Gate is
    port(x1: in std_logic;
         x2: in std_logic;
         y: out std_logic);
  end component;

begin
  dut_instance: OR_Gate
  port map(x1 => i1, x2 => i2, y => g);

  process
  begin

    i1 <= '0';
    i2 <= '0';

    wait for 1 ns;

    i1 <= '0';
    i2 <= '1';

    wait for 1 ns;

    i1 <= '1';
    i2 <= '0';

    wait for 1 ns;

    i1 <= '1';
    i2 <= '1';

    wait for 1 ns;

    end process;

end architecture;
