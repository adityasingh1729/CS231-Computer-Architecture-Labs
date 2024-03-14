library IEEE;
use IEEE.std_logic_1164.all;

entity not_tb is
end entity;

architecture tb of not_tb is

  signal i: std_logic;
  signal g: std_logic;

  component NOT_Gate is
    port(x: in std_logic;
         y: out std_logic);
  end component;

begin
  dut_instance: NOT_Gate
  port map(x => i, y => g);

  process
  begin

    i <= '0';

    wait for 1 ns;

    i <= '1';

    wait for 1 ns;

    end process;

end architecture;