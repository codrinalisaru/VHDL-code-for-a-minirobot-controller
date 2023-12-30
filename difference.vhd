library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
entity Disp_scadere is
port
(signal a: in std_logic_vector(3 downto 0);
signal b : in std_logic_vector(3 downto 0);
signal k: in std_logic_vector(1 downto 0);
signal dif: out std_logic_vector(5 downto 0));
end Disp_scadere;
architecture arch_Disp_scadere of Disp_scadere is
signal c1: std_logic_vector(3 downto 0);
signal c2: std_logic_vector(3 downto 0);
signal dv: std_logic_vector(3 downto 0);
begin
c1<=not b;
c2<=c1+1;
dv<=a+c2;
dif<=k*dv;
end arch_Disp_scadere;