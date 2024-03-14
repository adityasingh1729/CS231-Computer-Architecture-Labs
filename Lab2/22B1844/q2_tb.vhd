library IEEE;
use IEEE.std_logic_1164.all;

entity tb is
end entity;

architecture testbench of tb is

  component decoder4x16 is
    port(a, b, c, d, enable: in std_logic;
         dec: out std_logic_vector(15 downto 0));
  end component;

  signal F1, F2, F3, F4, E: std_logic;
  --signal G: std_logic_vector(15 downto 0);
  signal G0, G1, G2, G3, G4, G5, G6, G7, G8, G9, G10, G11, G12, G13, G14, G15: std_logic;
  begin
    dut_instance: decoder4x16
      port map(a => F1,
               b => F2,
               c => F3,
               d => F4,
               enable => E,
               dec(15) => G15,
               dec(14) => G14,
               dec(13) => G13,
               dec(12) => G12,
               dec(11) => G11,
               dec(10) => G10,
               dec(9) => G9,
               dec(8) => G8,
               dec(7) => G7,
               dec(6) => G6,
               dec(5) => G5,
               dec(4) => G4,
               dec(3) => G3,
               dec(2) => G2,
               dec(1) => G1,
               dec(0) => G0);
    process
    begin

      E <= '1';

      F1 <= '0';
      F2 <= '0';
      F3 <= '0';
      F4 <= '0';

      wait for 1 ns;

      F1 <= '0';
      F2 <= '0';
      F3 <= '0';
      F4 <= '1';

      wait for 1 ns;

      F1 <= '0';
      F2 <= '0';
      F3 <= '1';
      F4 <= '0';

      wait for 1 ns;

      F1 <= '0';
      F2 <= '0';
      F3 <= '1';
      F4 <= '1';

      wait for 1 ns;      

      F1 <= '0';
      F2 <= '1';
      F3 <= '0';
      F4 <= '0';

      wait for 1 ns;

      F1 <= '0';
      F2 <= '1';
      F3 <= '0';
      F4 <= '1';

      wait for 1 ns;      

      F1 <= '0';
      F2 <= '1';
      F3 <= '1';
      F4 <= '0';

      wait for 1 ns;

      F1 <= '0';
      F2 <= '1';
      F3 <= '1';
      F4 <= '1';

      wait for 1 ns;      

      F1 <= '1';
      F2 <= '0';
      F3 <= '0';
      F4 <= '0';

      wait for 1 ns;

      F1 <= '1';
      F2 <= '0';
      F3 <= '0';
      F4 <= '1';

      wait for 1 ns;

      F1 <= '1';
      F2 <= '0';
      F3 <= '1';
      F4 <= '0';

      wait for 1 ns;

      F1 <= '1';
      F2 <= '0';
      F3 <= '1';
      F4 <= '1';

      wait for 1 ns;      

      F1 <= '1';
      F2 <= '1';
      F3 <= '0';
      F4 <= '0';

      wait for 1 ns;

      F1 <= '1';
      F2 <= '1';
      F3 <= '0';
      F4 <= '1';

      wait for 1 ns;      

      F1 <= '1';
      F2 <= '1';
      F3 <= '1';
      F4 <= '0';

      wait for 1 ns;

      F1 <= '1';
      F2 <= '1';
      F3 <= '1';
      F4 <= '1';

      wait for 1 ns;

      end process;

    end architecture;
