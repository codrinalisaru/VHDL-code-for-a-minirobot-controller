library ieee;
use ieee.std_logic_1164.all;
entity Decodificator is
port
(signal c: in std_logic_vector(3 downto 0);
signal sens1 : out std_logic;
signal sens2 : out std_logic;
signal startstop1 : out std_logic;
signal startstop2 : out std_logic);
end Decodificator;
architecture arch_Decodificator of Decodificator is
begin
sens1<='1' when c="1110" or c="1101" or c="0101" else '0';
sens2<='1' when c="1110" or c="1100" or c="0100" else '0';
startstop1<='1' when c="1110" or c="1101" or c="1010" or c="1001" or c="0100" or c="0101" else '0';
startstop2<='1' when c="1110" or c="1100" or c="1010" or c="1000" or c="0100" or c="0101" else '0';
end arch_Decodificator;