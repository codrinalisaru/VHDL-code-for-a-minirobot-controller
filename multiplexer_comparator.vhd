library ieee;
use ieee.std_logic_1164.all;
entity CompMux is
port
(signal vp: in std_logic_vector(3 downto 0);
signal t : in std_logic_vector(3 downto 0);
signal a: out std_logic_vector(3 downto 0);
signal b: out std_logic_vector(3 downto 0);
signal semn: buffer std_logic);
end CompMux;
architecture arch_CompMux of CompMux is
begin
semn<='1' when vp>=t
else '0';
with semn select
a<=t when '0',
vp when others ;
with semn select
b<=t when '1',
vp when others;
end arch_CompMux;