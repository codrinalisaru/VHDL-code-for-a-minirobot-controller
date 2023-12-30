library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
entity Sistem_reglare is
port
(signal vp: in std_logic_vector(3 downto 0);
signal t : in std_logic_vector(3 downto 0);
signal dif: out std_logic_vector(5 downto 0);
signal semn: buffer std_logic;
signal k: in std_logic_vector(1 downto 0));
end Sistem_reglare;
architecture arch_Sistem_reglare of Sistem_reglare is
signal a: std_logic_vector(3 downto 0);
signal b: std_logic_vector(3 downto 0);
signal c1: std_logic_vector(3 downto 0);
signal c2: std_logic_vector(3 downto 0);
signal dv: std_logic_vector(3 downto 0);
begin
semn<='1' when vp>=t
else '0';
with semn select
a<=t when '0',
vp when others ;
with semn select
b<=t when '1',
vp when others;
c1<=not b;
c2<=c1+1;
dv<=a+c2;
dif<=k*dv;
end arch_Sistem_reglare;