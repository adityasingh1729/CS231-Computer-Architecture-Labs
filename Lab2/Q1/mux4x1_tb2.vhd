library IEEE;
use IEEE.std_logic_1164.all;

entity mux4x1_tb is
end entity;

architecture tb of mux4x1_tb is

  component mux4x1 is
    port (
      D : in std_logic_vector (3 downto 0);
      S : in std_logic_vector(1 downto 0);
      Y : out std_logic
    );
  end component;

  signal A, B, C, D_input, S0, S1: std_logic;  -- Changed D to D_input to avoid naming conflict
  signal Z: std_logic;

begin
  dut_instance: mux4x1
    port map (
      D => D_input,  -- Use D_input instead of D
      S => S0 & S1,  -- Concatenate S0 and S1 to match the 2-bit S input
      Y => Z
    );
    
  process
  begin
    wait for 1 ns;
    A <= '1';
    B <= '0';
    C <= '1';
    D_input <= '0';  -- Use D_input instead of D

    S0 <= '0';
    S1 <= '0';
 
    wait for 1 ns; 
 
    S0 <= '1';
    S1 <= '0';
 
    wait for 1 ns; 
 
    S0 <= '0';
    S1 <= '1';
 
    wait for 1 ns;   
 
    S0 <= '0';
    S1 <= '1';  
 
    wait for 1 ns;   
 
  end process;
 
end architecture;
