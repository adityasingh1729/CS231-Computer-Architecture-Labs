library IEEE;
use IEEE.std_logic_1164.all;

entity decoder4x16 is
    port (
        D: in std_logic_vector(3 downto 0);
        enable: in std_logic;
        Y: out std_logic_vector(15 downto 0)
    );
end entity;

architecture behaviour of decoder4x16 is

    component decoder2x4 is
        port (
            D: in std_logic_vector(1 downto 0);
            enable: in std_logic;
            Y: out std_logic_vector(3 downto 0)
        );
    end component;

    signal enable_internal: std_logic;

begin
    enable_internal <= enable; -- Use enable directly or process it as needed

    decoder0: decoder2x4 port map(D => D(1 downto 0), enable => enable_internal, Y => Y(3 downto 0));
    decoder1: decoder2x4 port map(D => D(3 downto 2), enable => enable_internal, Y => Y(7 downto 4));
    decoder2: decoder2x4 port map(D => D(5 downto 4), enable => enable_internal, Y => Y(11 downto 8));
    decoder3: decoder2x4 port map(D => D(7 downto 6), enable => enable_internal, Y => Y(15 downto 12));


    
end architecture;
