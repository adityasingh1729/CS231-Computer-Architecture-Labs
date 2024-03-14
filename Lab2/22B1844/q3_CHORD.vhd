library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

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
  signal outputArray: array_of_vectors(100 downto 0);
  signal curr_out: integer := 0;
  signal chord_out: std_logic_vector(7 downto 0);
  signal chord_type: std_logic_vector(7 downto 0);
  signal chord_detected: boolean := false;
  signal keys: array_of_vectors(11 downto 0);
  signal int_keys: IntegerVector(11 downto 0);
  signal a_store: std_logic_vector(7 downto 0);

  -- Defining type of chords
  signal M: std_logic_vector(7 downto 0):= "01001101";
  signal small_m: std_logic_vector(7 downto 0):= "01101101";
  signal s: std_logic_vector(7 downto 0):= "01110011";
  signal seven: std_logic_vector(7 downto 0):= "00110111";
  signal sharp: std_logic_vector(7 downto 0):= "00011111";

  function vector_to_string(v: std_logic_vector) return string is
        variable result: string(0 to v'length - 1);
    begin
        for i in v'range loop
            if v(i) = '0' then
                result(i) := '0';
            else
                result(i) := '1';
            end if;
        end loop;
        return result;
    end function;

  
  begin

  data_valid <= '1';
  
  keys(0) <= "01000011";     -- C
  keys(1) <= "01100100";     -- d
  keys(2) <= "01000100";     -- D
  keys(3) <= "01100101";     -- e   
  keys(4) <= "01000101";     -- E
  keys(5) <= "01000110";     -- F
  keys(6) <= "01100111";     -- g
  keys(7) <= "01000111";     -- G
  keys(8) <= "01100001";     -- a
  keys(9) <= "01000001";     -- A
  keys(10) <= "01100010";     -- b
  keys(11) <= "01000010";     -- B

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
      variable buff_ptr: integer := 0;
      variable clk_counter: integer := 0;
      variable out_ptr: integer := 0;
    begin
    --if rst = '1' then
      --buff <= (others => (others => '0'));
      --outputArray <= (others => (others => '0'));
      --buff_ptr := 0;
      --out_ptr <= 0;
      --curr_out <= 0;
      --chord_detected <= false;
      --data_valid <= '0';
      --z <= (others => '0');
    --if a /= "11111111" or buff_ptr = 0 then
    if rising_edge(clk) then
      clk_counter := clk_counter + 1;
      report "buff_ptr " &integer'image(buff_ptr) severity note;
      if buff_ptr < 3 and clk_counter < 33 then
        buff(buff_ptr) <= a;
        report "a " & vector_to_string(a);
        report "buff(0) " & vector_to_string(buff(0));
        report "buff(1) " & vector_to_string(buff(1));
        report "buff(2) " & vector_to_string(buff(2));
        report "buff(3) " & vector_to_string(buff(3));        
          buff_ptr := buff_ptr + 1;
          if a = keys(0) then
            report "TRUE0" severity note;
          else
            report "FALSE0" severity note;
          end if;

          if a = keys(4) then
            report "TRUE1" severity note;
          else
            report "FALSE1" severity note;
          end if;

          if a = keys(7) then
            report "TRUE2" severity note;
          else
            report "FALSE2" severity note;
          end if;
      else
        report "a " & vector_to_string(a);
        report "buff(0) " & vector_to_string(buff(0));
        report "buff(1) " & vector_to_string(buff(1));
        report "buff(2) " & vector_to_string(buff(2));
        report "buff(3) " & vector_to_string(buff(3));
        report "I am here" severity note;
        report "Clock Counter: " &integer'image(clk_counter);
        if chord_detected = false then
          if ((buff(0) = keys(0) and buff(1) = keys(4) and buff(2) = keys(7) and a = keys(10)) or
              (buff(0) = keys(1) and buff(1) = keys(5) and buff(2) = keys(8) and a = keys(11)) or
              (buff(0) = keys(2) and buff(1) = keys(6) and buff(2) = keys(9) and a = keys(0)) or
              (buff(0) = keys(3) and buff(1) = keys(7) and buff(2) = keys(10) and a = keys(1)) or
              (buff(0) = keys(4) and buff(1) = keys(8) and buff(2) = keys(11) and a = keys(2)) or
              (buff(0) = keys(5) and buff(1) = keys(9) and buff(2) = keys(0) and a = keys(3)) or
              (buff(0) = keys(6) and buff(1) = keys(10) and buff(2) = keys(1) and a = keys(4)) or
              (buff(0) = keys(7) and buff(1) = keys(11) and buff(2) = keys(2) and a = keys(5)) or
              (buff(0) = keys(8) and buff(1) = keys(0) and buff(2) = keys(3) and a = keys(6)) or
              (buff(0) = keys(9) and buff(1) = keys(1) and buff(2) = keys(4) and a = keys(7)) or
              (buff(0) = keys(10) and buff(1)= keys(2) and buff(2) = keys(5) and a = keys(8)) or
              (buff(0) = keys(11) and buff(1) = keys(3) and buff(2) = keys(6) and a = keys(9))
             ) then
            report "Seven" severity note;
            chord_out <= buff(0);
            --outputArray(out_ptr) <= buff(0);
            --out_ptr <= out_ptr + 1;
            chord_type <= seven;
            chord_detected <= true;
            
           elsif ((buff(0) = keys(0) and buff(1) = keys(4) and buff(2) = keys(7)) or
                 (buff(0) = keys(1) and buff(1) = keys(5) and buff(2) = keys(8)) or
                 (buff(0) = keys(2) and buff(1) = keys(6) and buff(2) = keys(9)) or
                 (buff(0) = keys(3) and buff(1) = keys(7) and buff(2) = keys(10)) or
                 (buff(0) = keys(4) and buff(1) = keys(8) and buff(2) = keys(11)) or
                 (buff(0) = keys(5) and buff(1) = keys(9) and buff(2) = keys(0)) or
                 (buff(0) = keys(6) and buff(1) = keys(10) and buff(2) = keys(1)) or
                 (buff(0) = keys(7) and buff(1) = keys(11) and buff(2) = keys(2)) or
                 (buff(0) = keys(8) and buff(1) = keys(0) and buff(2) = keys(3)) or
                 (buff(0) = keys(9) and buff(1) = keys(1) and buff(2) = keys(4)) or
                 (buff(0) = keys(10) and buff(1) = keys(2) and buff(2) =keys(5)) or
                 (buff(0) = keys(11) and buff(1) = keys(3) and buff(2) =keys(6))
                 ) then
             report "Major" severity note;
             chord_out <= buff(0);
             --outputArray(out_ptr) <= buff(0);
            --out_ptr <= out_ptr + 1;
             buff(3) <= a;
             chord_type <= M;
             chord_detected <= true;
             
           elsif ((buff(0) = keys(0) and buff(1) = keys(3) and buff(2) = keys(7)) or
                  (buff(0) = keys(1) and buff(1) = keys(4) and buff(2) = keys(8)) or
                  (buff(0) = keys(2) and buff(1) = keys(5) and buff(2) = keys(9)) or
                  (buff(0) = keys(3) and buff(1) = keys(6) and buff(2) = keys(10)) or
                  (buff(0) = keys(4) and buff(1) = keys(7) and buff(2) = keys(11)) or
                  (buff(0) = keys(5) and buff(1) = keys(8) and buff(2) = keys(0)) or
                  (buff(0) = keys(6) and buff(1) = keys(9) and buff(2) = keys(1)) or
                  (buff(0) = keys(7) and buff(1) = keys(10) and buff(2) = keys(2)) or
                  (buff(0) = keys(8) and buff(1) = keys(11) and buff(2) = keys(3)) or
                  (buff(0) = keys(9) and buff(1) = keys(0) and buff(2) = keys(4)) or
                  (buff(0) = keys(10) and buff(1) = keys(1) and buff(2) = keys(5)) or
                  (buff(0) = keys(11) and buff(1) = keys(2) and buff(2) = keys(6))                 
                 ) then
             report "Minor" severity note;
             --outputArray(out_ptr) <= buff(0);
             --out_ptr <= out_ptr + 1;
             buff(3) <= a;
             chord_out <= buff(0);
             chord_type <= small_m;
             chord_detected <= true;

           elsif ((buff(0) = keys(0) and buff(1) = keys(5) and buff(2) = keys(7)) or
                  (buff(0) = keys(1) and buff(1) = keys(6) and buff(2) = keys(8)) or
                  (buff(0) = keys(2) and buff(1) = keys(7) and buff(2) = keys(9)) or
                  (buff(0) = keys(3) and buff(1) = keys(8) and buff(2) = keys(10)) or
                  (buff(0) = keys(4) and buff(1) = keys(9) and buff(2) = keys(11)) or
                  (buff(0) = keys(5) and buff(1) = keys(10) and buff(2) = keys(0)) or
                  (buff(0) = keys(6) and buff(1) = keys(11) and buff(2) = keys(1)) or
                  (buff(0) = keys(7) and buff(1) = keys(0) and buff(2) = keys(2)) or
                  (buff(0) = keys(8) and buff(1) = keys(1) and buff(2) = keys(3)) or
                  (buff(0) = keys(9) and buff(1) = keys(2) and buff(2) = keys(4)) or
                  (buff(0) = keys(10) and buff(1) = keys(3) and buff(2) = keys(5)) or
                  (buff(0) = keys(11) and buff(1) = keys(4) and buff(2) = keys(6))
                 ) then
             report "Suspended" severity note;
             --outputArray(out_ptr) <= buff(0);
            --out_ptr <= out_ptr + 1;
             buff(3) <= a;
             chord_out <= buff(0);
             chord_type <= s;
             chord_detected <= true;
           else
             report "NOTHING" severity note;
             outputArray(out_ptr) <= buff(0);
             out_ptr := out_ptr + 1;
             buff(0) <= buff(1);
             buff(1) <= buff(2);
             buff(2) <= a;
          end if;
      end if;
        if chord_detected = true then
          report "Chord Detected of type: "  & vector_to_string(chord_type);
          outputArray(out_ptr) <= chord_out;
          out_ptr := out_ptr + 1;
          report "chord_out " & vector_to_string(outputArray(out_ptr));          
          outputArray(out_ptr) <= chord_type;
          out_ptr := out_ptr + 1;
          report "chord_type " & vector_to_string(outputArray(out_ptr));
          if chord_type = seven then
            buff <= (others => (others => '0'));
            buff_ptr := 0;
            buff(0) <= a;
            buff_ptr := 1;
            report "buff(0) after exiting " & vector_to_string(buff(0));
           else
            --buff <= (others => (others => '0'));
            buff(0) <= buff(3);
            buff(1) <= a;
            buff_ptr := 2;
            buff(2) <= "00000000";
            buff(3) <= "00000000";
            report "buff(0) after EXITING " & vector_to_string(buff(0));
            report "buff(1) after EXITING " & vector_to_string(buff(1));
          end if;
        chord_detected <= false;
        chord_type <= (others => '0');
        end if;
        --OUTPUT Printing:
      if clk_counter > 32 and curr_out < out_ptr + 1 then
        
        data_valid <= '1';
        report "Curr_out " &integer'image(curr_out);
        if out_ptr > 0 then
        report "z " & vector_to_string(outputArray(curr_out));
          z <= outputArray(curr_out);
          curr_out <= curr_out + 1;
        report "report ptr: " &integer'image(out_ptr);
        end if;
      end if;
      end if;
    end if;
  end process;
end behaviour;
  
