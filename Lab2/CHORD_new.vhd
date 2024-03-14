library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use std.textio.all;

entity CHORDEncoder is
    	port(clk, rst: in std_logic;
             a: in std_logic_vector(7 downto 0);
             data_valid: out std_logic;
             z: out std_logic_vector(7 downto 0));
end entity;

architecture behaviour of CHORDEncoder is
  type array_of_vectors is array  (natural range <>) of std_logic_vector(7 downto 0);
  signal buff: array_of_vectors(3 downto 0);
  type IntegerVector is array (natural range <>) of integer;
  --signal buff_int: IntegerVector(3 downto 0);
  signal outputArray: array_of_vectors(32 downto 0);
  signal out_ptr: integer := 0;
  signal buff_ptr: integer := 0;
  signal curr_out: integer := 0;
  signal chord_out: std_logic_vector(7 downto 0);
  signal chord_type: std_logic_vector(7 downto 0);
  signal chord_detected: boolean := false;
  signal keys: array_of_vectors(11 downto 0);
  signal int_keys: IntegerVector(11 downto 0);

  -- Defining type of chords
  signal M: std_logic_vector(7 downto 0):= "01001101";
  signal small_m: std_logic_vector(7 downto 0):= "01101101";
  signal s: std_logic_vector(7 downto 0):= "01110011";
  signal seven: std_logic_vector(7 downto 0):= "00110111";
  signal sharp: std_logic_vector(7 downto 0):= "00011111";
  
  begin
  
  --keys(0) <= "01000011";     -- C
  --keys(1) <= "01100100";     -- d
  --keys(2) <= "01000100";     -- D
  --keys(3) <= "01100101";     -- e   
  --keys(4) <= "01000101";     -- E
  --keys(5) <= "01000110";     -- F
  --keys(6) <= "01100111";     -- g
  --keys(7) <= "01000111";     -- G
  --keys(8) <= "01100001";     -- a
  --keys(9) <= "01000001";     -- A
  --keys(10) <= "01100010";     -- b
  --keys(11) <= "01000010";     -- B

  int_keys(0) <= 01000011;     -- C
  int_keys(1) <= 01100100;     -- d
  int_keys(2) <= 01000100;     -- D
  int_keys(3) <= 01100101;     -- e   
  int_keys(4) <= 01000101;     -- E
  int_keys(5) <= 01000110;     -- F
  int_keys(6) <= 01100111;     -- g
  int_keys(7) <= 01000111;     -- G
  int_keys(8) <= 01100001;     -- a
  int_keys(9) <= 01000001;     -- A
  int_keys(10) <= 01100010;     -- b
  int_keys(11) <= 01000010;     -- B

  process(clk, rst)
    begin
    --if rst = '1' then
      --buff <= (others => (others => '0'));
      --outputArray <= (others => (others => '0'));
      --buff_ptr <= 0;
      --out_ptr <= 0;
      --curr_out <= 0;
      --chord_detected <= false;
      --data_valid <= '0';
      --z <= (others => '0');
      data_valid <= '1';
      report "buff_ptr " &integer'image(buff_ptr) severity note;
      if buff_ptr < 3 then
          buff(buff_ptr) <= a;
          buff_ptr <= buff_ptr + 1;
      else
        report "I am here" severity note;
        if buff(0) = "01000011" then
          report "something" severity note;
          end if;
        --if chord_detected = false then
          if ((buff(0) = int_keys(0) and buff(1) = int_keys(4) and buff(2) = int_keys(7) and a = int_keys(10)) or
              (buff(0) = int_keys(1) and buff(1) = int_keys(5) and buff(2) = int_keys(8) and a = int_keys(11)) or
              (buff(0) = int_keys(2) and buff(1) = int_keys(6) and buff(2) = int_keys(9) and a = int_keys(0)) or
              (buff(0) = int_keys(3) and buff(1) = int_keys(7) and buff(2) = int_keys(10) and a = int_keys(1)) or
              (buff(0) = int_keys(4) and buff(1) = int_keys(8) and buff(2) = int_keys(11) and a = int_keys(2)) or
              (buff(0) = int_keys(5) and buff(1) = int_keys(9) and buff(2) = int_keys(0) and a = int_keys(3)) or
              (buff(0) = int_keys(6) and buff(1) = int_keys(10) and buff(2) = int_keys(1) and a = int_keys(4)) or
              (buff(0) = int_keys(7) and buff(1) = int_keys(11) and buff(2) = int_keys(2) and a = int_keys(5)) or
              (buff(0) = int_keys(8) and buff(1) = int_keys(0) and buff(2) = int_keys(3) and a = int_keys(6)) or
              (buff(0) = int_keys(9) and buff(1) = int_keys(1) and buff(2) = int_keys(4) and a = int_keys(7)) or
              (buff(0) = int_keys(10) and buff(1) = int_keys(2) and buff(2) = int_keys(5) and a = int_keys(8)) or
              (buff(0) = int_keys(11) and buff(1) = int_keys(3) and buff(2) = int_keys(6) and a = int_keys(9))
             ) then
            report "SEVEN DETECTED" severity note;
            chord_out <= buff(0);
            chord_type <= seven;
            chord_detected <= true;
            
           elsif ((buff(0) = int_keys(0) and buff(1) = int_keys(4) and buff(2) = int_keys(7)) or
                  (buff(0) = int_keys(1) and buff(1) = int_keys(5) and buff(2) = int_keys(8)) or
                  (buff(0) = int_keys(2) and buff(1) = int_keys(6) and buff(2) = int_keys(9)) or
                  (buff(0) = int_keys(3) and buff(1) = int_keys(7) and buff(2) = int_keys(10)) or
                  (buff(0) = int_keys(4) and buff(1) = int_keys(8) and buff(2) = int_keys(11)) or
                  (buff(0) = int_keys(5) and buff(1) = int_keys(9) and buff(2) = int_keys(0)) or
                  (buff(0) = int_keys(6) and buff(1) = int_keys(10) and buff(2) = int_keys(1)) or
                  (buff(0) = int_keys(7) and buff(1) = int_keys(11) and buff(2) = int_keys(2)) or
                  (buff(0) = int_keys(8) and buff(1) = int_keys(0) and buff(2) = int_keys(3)) or
                  (buff(0) = int_keys(9) and buff(1) = int_keys(1) and buff(2) = int_keys(4)) or
                  (buff(0) = int_keys(10) and buff(1) = int_keys(2) and buff(2) = int_keys(5)) or
                  (buff(0) = int_keys(11) and buff(1) = int_keys(3) and buff(2) = int_keys(6))
                 ) then
             report "MAJOR DETECTED" severity note;
             chord_out <= buff(0);
             chord_type <= M;
             chord_detected <= true;
             
           elsif ((buff(0) = int_keys(0) and buff(1) = int_keys(3) and buff(2) = int_keys(7)) or
                  (buff(0) = int_keys(1) and buff(1) = int_keys(4) and buff(2) = int_keys(8)) or
                  (buff(0) = int_keys(2) and buff(1) = int_keys(5) and buff(2) = int_keys(9)) or
                  (buff(0) = int_keys(3) and buff(1) = int_keys(6) and buff(2) = int_keys(10)) or
                  (buff(0) = int_keys(4) and buff(1) = int_keys(7) and buff(2) = int_keys(11)) or
                  (buff(0) = int_keys(5) and buff(1) = int_keys(8) and buff(2) = int_keys(0)) or
                  (buff(0) = int_keys(6) and buff(1) = int_keys(9) and buff(2) = int_keys(1)) or
                  (buff(0) = int_keys(7) and buff(1) = int_keys(10) and buff(2) = int_keys(2)) or
                  (buff(0) = int_keys(8) and buff(1) = int_keys(11) and buff(2) = int_keys(3)) or
                  (buff(0) = int_keys(9) and buff(1) = int_keys(0) and buff(2) = int_keys(4)) or
                  (buff(0) = int_keys(10) and buff(1) = int_keys(1) and buff(2) = int_keys(5)) or
                  (buff(0) = int_keys(11) and buff(1) = int_keys(2) and buff(2) = int_keys(6))
                 ) then
             report "MINOR DETECTED" severity note;
             chord_out <= buff(0);
             chord_type <= small_m;
             chord_detected <= true;

           elsif ((buff(0) = int_keys(0) and buff(1) = int_keys(5) and buff(2) = int_keys(7)) or
                  (buff(0) = int_keys(1) and buff(1) = int_keys(6) and buff(2) = int_keys(8)) or
                  (buff(0) = int_keys(2) and buff(1) = int_keys(7) and buff(2) = int_keys(9)) or
                  (buff(0) = int_keys(3) and buff(1) = int_keys(8) and buff(2) = int_keys(10)) or
                  (buff(0) = int_keys(4) and buff(1) = int_keys(9) and buff(2) = int_keys(11)) or
                  (buff(0) = int_keys(5) and buff(1) = int_keys(10) and buff(2) = int_keys(0)) or
                  (buff(0) = int_keys(6) and buff(1) = int_keys(11) and buff(2) = int_keys(1)) or
                  (buff(0) = int_keys(7) and buff(1) = int_keys(0) and buff(2) = int_keys(2)) or
                  (buff(0) = int_keys(8) and buff(1) = int_keys(1) and buff(2) = int_keys(3)) or
                  (buff(0) = int_keys(9) and buff(1) = int_keys(2) and buff(2) = int_keys(4)) or
                  (buff(0) = int_keys(10) and buff(1) = int_keys(3) and buff(2) = int_keys(5)) or
                  (buff(0) = int_keys(11) and buff(1) = int_keys(4) and buff(2) = int_keys(6))
                 ) then
             report "SUSPENDED DETECTED" severity note;
             chord_out <= buff(0);
             chord_type <= s;
             chord_detected <= true;
           else
             report "CHORD NOT DETECTED" severity note;
             outputArray(out_ptr) <= buff(0);
             out_ptr <= out_ptr + 1;
             buff(0) <= buff(1);
             buff(1) <= buff(2);
             buff(2) <= a;
             -- Here error may occur because a may be null.
          end if;   
        --end if;

        if chord_detected = true then
          report "CHORD DETECTED" severity note;
          outputArray(out_ptr) <= chord_out;
          out_ptr <= out_ptr + 1;
          outputArray(out_ptr) <= chord_type;
          out_ptr <= out_ptr + 1;
          if chord_type = 00110111 then
            buff <= (others => (others => '0'));
            buff_ptr <= 0;
          else
            buff <= (others => (others => '0'));
            buff(0) <= a;
            buff_ptr <= 1;
          end if;
          chord_detected <= false;
        end if;
        end if;
        if a = 00000000 then
          data_valid <= '1';
            if out_ptr > 0 then
              z <= outputArray(curr_out);
              curr_out <= curr_out + 1;
            end if;
            report "Curr_out" &integer'image(curr_out) severity note;
            report "Out_ptr " &integer'image(out_ptr) severity note;
        end if;
  end process;
end behaviour;
  
