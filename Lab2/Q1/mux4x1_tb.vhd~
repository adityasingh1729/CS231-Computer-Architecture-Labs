library IEEE;
use IEEE.std_logic_1164.all;

entity mux4x1_tb is
end entity;

architecture tb of mux4x1_tb is

  component mux4x1 is
    port(D: in std_logic_vector (3 downto 0);
         S: in std_logic_vector(1 downto 0);
         Y: out std_logic);
  end component;

  signal A, B, C, D: std_logic;
  signal S1, S0: std_logic;
  signal Z: std_logic;

begin
  dut_instance: mux4x1
    port map(D(0) => A,
             D(1) => B,
             D(2) => C,
             D(3) => D,
             S(1) => S1,
             S(0) => S0,
             Y => Z);
  process
  begin

    A <= '1';
    B <= '0';
    C <= '1';
    D <= '0';

    S0 <= '0';
    S1 <= '0';
 
    wait for 1 ns; 
 
    S0 <= '1';
    S1 <= '0';
 
    wait for 1 ns; 
 
    S0 <= '0';
    S1 <= '1';
 
    wait for 1 ns;   
 
    S0 <= '1';
    S1 <= '1';  
 
    wait for 1 ns;

    A <= '1';
    B <= '1';
    C <= '0';
    D <= '0';

    S0 <= '0';
    S1 <= '0';
 
    wait for 1 ns; 
 
    S0 <= '1';
    S1 <= '0';
 
    wait for 1 ns; 
 
    S0 <= '0';
    S1 <= '1';
 
    wait for 1 ns;   
 
    S0 <= '1';
    S1 <= '1';  
 
    wait for 1 ns;
 
    end process;
 
  end architecture;
