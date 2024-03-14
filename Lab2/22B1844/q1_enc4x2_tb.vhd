library IEEE;
use IEEE.std_logic_1164.all;

entity encoder4x2_tb is
end entity;

architecture tb of encoder4x2_tb is

  component encoder4x2 is
    port(I: in std_logic_vector (3 downto 0);
         Y: out std_logic_vector(1 downto 0));
  end component;

  signal A, B, C, D: std_logic;
  signal Y1, Y0: std_logic;
  
  begin
    dut_instance: encoder4x2
      port map(I(0) => A,
               I(1) => B,
               I(2) => C,
               I(3) => D,
               Y(1) => Y1,
               Y(0) => Y0);

    process
    begin

      A <= '1';
      B <= '0';
      C <= '0';
      D <= '0';

      wait for 1 ns;

      A <= '0';
      B <= '1';
      C <= '0';
      D <= '0';

      wait for 1 ns;

      A <= '0';
      B <= '0';
      C <= '1';
      D <= '0';

      wait for 1 ns;

      A <= '0';
      B <= '0';
      C <= '0';
      D <= '1';

      wait for 1 ns;

      end process;
      
    end architecture;
                 