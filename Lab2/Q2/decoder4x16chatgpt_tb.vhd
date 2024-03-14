library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity testbench_decoder4x16 is
end entity testbench_decoder4x16;

architecture testbench of testbench_decoder4x16 is
    signal D : std_logic_vector(3 downto 0);
    signal enable : std_logic;
    signal Y : std_logic_vector(15 downto 0);

    component decoder4x16 is
        port (
            D: in std_logic_vector(3 downto 0);
            enable: in std_logic;
            Y: out std_logic_vector(15 downto 0)
        );
    end component;

begin
    -- Instantiate the 4x16 decoder
    UUT : decoder4x16 port map (D => D, enable => enable, Y => Y);

    -- Stimulus process
    stim_proc : process
    begin
        enable <= '1';  -- Enable the decoder

        for i in 0 to 15 loop
            D <= to_stdlogicvector(i, 4);  -- Apply input values from 0 to 15
            wait for 10 ns;
        end loop;

        enable <= '0';  -- Disable the decoder
        wait for 10 ns;

        -- Add more test cases as needed

        wait;
    end process;

    -- Monitor process
    monitor_proc : process
    begin
        wait for 5 ns;  -- Wait for signals to stabilize

        for i in 0 to 15 loop
            report "Input D = " & integer'image(i) & ", Output Y = " & std_logic'image(Y) severity note;
            wait for 10 ns;
        end loop;

        wait;

    end process;

end architecture testbench;
