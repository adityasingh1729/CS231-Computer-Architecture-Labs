library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CHORD_Encoder is
    Port (
        clk, rst: in std_logic;
        a: in std_logic_vector(7 downto 0);
        data_valid: out std_logic;
        z: out std_logic_vector(7 downto 0)
    );
end CHORD_Encoder;

architecture Behavioral of CHORD_Encoder is
    signal buffer: std_logic_vector(7 downto 0)(0 to 31);
    signal buffer_ptr: integer := 0;
    signal chord_detected: boolean := false;
    signal chord_output: std_logic_vector(7 downto 0);
    signal prev_a: std_logic_vector(7 downto 0) := (others => '0'); -- Store previous note

begin
    process(clk, rst)
    begin
        if rst = '1' then
            -- Reset the circuit
            buffer <= (others => (others => '0'));
            buffer_ptr <= 0;
            chord_detected <= false;
            data_valid <= '0';
            z <= (others => '0');
            prev_a <= (others => '0');
        elsif rising_edge(clk) then
            -- Read and process incoming notes
            if buffer_ptr < 32 then
                buffer(buffer_ptr) <= a;
                buffer_ptr <= buffer_ptr + 1;
            else
                -- Buffer full, process chords here
                if chord_detected = false then
                    -- Detect chords based on rules and set chord_detected flag
                    if prev_a = "01000011" and a = "01011011" and buffer(buffer_ptr-2) = "01011001" then
                        -- Major (M) chord detected
                        chord_output <= "01001101";  -- ASCII M
                        chord_detected <= true;
                    elsif prev_a = "01000011" and a = "01100100" and buffer(buffer_ptr-2) = "01100110" then
                        -- Minor (m) chord detected
                        chord_output <= "01101101";  -- ASCII m
                        chord_detected <= true;
                    elsif prev_a = "01000011" and a = "01100100" and buffer(buffer_ptr-2) = "01101001" then
                        -- Suspended (s) chord detected
                        chord_output <= "01110011";  -- ASCII s
                        chord_detected <= true;
                    elsif prev_a = "01000011" and a = "01100100" and buffer(buffer_ptr-2) = "01000011" then
                        -- Dominant 7th (7) chord detected
                        chord_output <= "00110111";  -- ASCII 7
                        chord_detected <= true;
                    end if;
                end if;

                if chord_detected = true then
                    -- Output the chord data
                    data_valid <= '1';
                    z <= chord_output;

                    -- Clear the buffer and reset buffer_ptr
                    buffer <= (others => (others => '0'));
                    buffer_ptr <= 0;
                    chord_detected <= false;
                end if;
            end if;

            -- Store current note as previous note for comparison
            prev_a <= a;
        end if;
    end process;
end Behavioral;
