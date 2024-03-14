library IEEE;
use IEEE.std_logic_1164.all;

entity decoder2x4_tb is
end entity;

architecture tb of decoder2x4_tb is

  component decoder2x4 is
    port(D1, D0: in std_logic;
         enable: in std_logic;
         Y: out std_logic_vector (3 downto 0));
  end component;

  signal A, B, E: std_logic;
  signal Y0, Y1, Y2, Y3: std_logic;

  begin
    dut_instance: decoder2x4
      port map(D0 => A,
               D1 => B,
               Y(0) => Y0,
               Y(1) => Y1,
               Y(2) => Y2,
               Y(3) => Y3,
               enable => E);
    process
    begin

      E <= '1';  -- enable
      
      A <= '1';
      B <= '0';

      wait for 1 ns;

      A <= '0';
      B <= '1';

      wait for 1 ns;

      A <= '1';
      B <= '1';

      wait for 1 ns;

      A <= '0';
      B <= '0';

      wait for 1 ns;

      E <= '0';   -- enable
      
      A <= '0';
      B <= '0';

      wait for 1 ns;

      A <= '1';
      B <= '0';

      wait for 1 ns;

      A <= '0';
      B <= '1';

      wait for 1 ns;

      A <= '1';
      B <= '1';

      wait for 1 ns;

      E <= '1';  -- enable
      
      A <= '1';
      B <= '1';

      wait for 1 ns;

      A <= '1';
      B <= '0';

      wait for 1 ns;

      A <= '0';
      B <= '0';

      wait for 1 ns;

      A <= '0';
      B <= '1';

      wait for 1 ns;

      E <= '0';  -- enable
      
      A <= '0';
      B <= '1';

      wait for 1 ns;

      A <= '1';
      B <= '1';

      wait for 1 ns;

      A <= '0';
      B <= '0';

      wait for 1 ns;

      A <= '1';
      B <= '0';

      wait for 1 ns;

      end process;

    end architecture;
