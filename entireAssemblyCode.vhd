library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
entity controller is
port (c_in, vp_in, t1_in, t2_in : in std_logic_vector(3 downto 0);
k_in: in std_logic_vector(1 downto 0);
clk, init: in std_logic;
sens1_out, sens2_out, start_stop1_out, start_stop2_out, semn1_out, semn2_out: out std_logic;
signal reset, load1, load2: buffer std_logic;
dif1_out, dif2_out: out std_logic_vector(5 downto 0));
end controller;
architecture arch_controller of controller is
signal c, vp, t1, t2: std_logic_vector (3 downto 0);
signal k : std_logic_vector(1 downto 0);
signal sens1, sens2, start_stop1, start_stop2, semn1, semn2: std_logic;
--signal reset, load1, load2: std_logic;
type STARE is (S0,S1,S2);
signal S: STARE;
signal dif1,dif2: std_logic_vector(5 downto 0);
signal a1,a2,b1,b2: std_logic_vector(3 downto 0);
signal c1,c2,c3,c4: std_logic_vector(3 downto 0);
signal dv1,dv2: std_logic_vector(3 downto 0);
begin
--registrul_in
process (clk, reset, load1)
begin
if clk'event and clk='0' then
if reset='1' then c<="0000";
vp<="0000";
t1<="0000";
t2<="0000";
k<="00";
elsif load1='1' then c<=c_in; vp<=vp_in; t1<=t1_in; t2<=t2_in; k<=k_in;
end if;
end if;
end process;
---registrul_out
process(clk, reset, load2)
begin
if clk'event and clk='0' then
if reset='1' then sens1_out<='0' ;
sens2_out<='0';
start_stop1_out<='0';
start_stop2_out<='0';
semn1_out<='0';
semn2_out<='0';
dif1_out<="000000";
dif2_out<="000000";
elsif load2='1' then sens1_out<=sens1;
sens2_out<=sens2;
start_stop1_out<=start_stop1;
start_stop2_out<=start_stop2;
semn1_out<=semn1;
semn2_out<=semn2;
dif1_out<=dif1;
dif2_out<=dif2;
end if;
end if;
end process;
---automat
process(init,clk)
begin
if init='1' then S<=S0;
elsif clk'event and clk='1' then
case S is
when S0=> S<=S1;
when S1=> S<=S2;
when S2=> S<=S1;
end case;
end if;
end process;
reset<='1' when S=S0 else
'0';
load1<='1' when S=S1 else
'0';
load2<='1' when S=S2 else
'0';
---bloc procesare
--decodificator
sens1<='1' when c="1110" or c="1101" or c="0101" else '0';
sens2<='1' when c="1110" or c="1100" or c="0100" else '0';
start_stop1<='0' when c="0000" or c="1100" or c="1000" else '1';
start_stop2<='0' when c="0000" or c="1101" or c="1001" else '1';
--SRA1
--Comparator1
semn1<='1' when vp>=t1 else '0';
--Multiplexor1
with semn1 select
a1<=t1 when '0',
vp when others;
with semn1 select
b1<=vp when '0',
t1 when others;
--disp_scadere1
c1<=not b1;
c2<=c1+1;
dv1<=a1+c2;
dif1<=k*dv1;
--SRA2
--Comparator2
semn2<='1' when t1>=t2 else '0';
--Multiplexor2
with semn2 select
a2<=t2 when '0',
t1 when others;
with semn2 select
b2<=t1 when '0',
t2 when others;
--disp_scadere2
c3<=not b2;
c4<=c3+1;
dv2<=a2+c4;
dif2<=k*dv2;
end arch_controller;