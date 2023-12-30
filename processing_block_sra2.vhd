library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
entity Sistem_reglare2 is
port
(signal vp: in std_logic_vector(3 downto 0);
signal t2 : in std_logic_vector(3 downto 0);
signal dif2: out std_logic_vector(5 downto 0);
signal semn2: buffer std_logic;
signal k: in std_logic_vector(1 downto 0));
end Sistem_reglare2;
architecture arch_Sistem_reglare2 of Sistem_reglare1 is
signal a2: std_logic_vector(3 downto 0);
signal b2: std_logic_vector(3 downto 0);
signal c1: std_logic_vector(3 downto 0);
signal c2: std_logic_vector(3 downto 0);
signal dv2: std_logic_vector(3 downto 0);
begin
semn2<='1' when vp>=t
else '0';
with semn select
a2<=t2 when '0',
vp when others ;
with semn select
b2<=t2 when '1',
vp when others;
c1<=not b;
c2<=c1+1;
dv2<=a+c2;
dif2<=k*dv;
end arch_Sistem_reglare2;