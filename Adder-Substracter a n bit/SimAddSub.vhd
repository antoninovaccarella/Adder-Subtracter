library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;  -- ARITH = aritmetica
library work; --directory in cui si trova il progetto attuale
use work.myfunc.all; --funzione ausiliaria
use work.myconst.all; --per l'nbitin

entity SimAddSub is
    generic (nb:integer := nbitin); 
end SimAddSub;
 
architecture Behavioral of SimAddSub is 
 
component AddSub is    
    Port ( A : in STD_LOGIC_VECTOR(nb-1 downto 0);
           B : in STD_LOGIC_VECTOR(nb-1 downto 0);
           C : in STD_LOGIC_VECTOR(nb-1 downto 0);
           clk : in STD_LOGIC;
           Ris : out STD_LOGIC_VECTOR(nb+1 downto 0));
end component;
 
signal IA, IB, IC : STD_LOGIC_VECTOR (nb-1 downto 0):=(others=>'0'); --segnali degli ingressi A, B e C
signal Iclk : STD_LOGIC:='0'; --segnale di clock
signal ORis: STD_LOGIC_VECTOR (nb+1 downto 0):=(others=>'0'); --segnale del risultato finale
constant Tclk: time:=10ns; --periodo del clock
 
begin
    Circuito : AddSub port map (IA, IB, IC, Iclk, ORis);
 
process 
begin
--t=0
   wait for Tclk+100ns; --global reset
    --utilizzo del for loop (versione sequenziale del for), di default va, vb e vc sono int, quindi con l'aiuto di ARITH li convertiamo in STD_LOGIC
    -- -2^(nb-1) : 2^(nb-1)-1
    -- simulazione esaustiva di tutti i possibili valori degli operandi 
      for va in -pow2(nb-1) to (pow2(nb-1)-1) loop 
        for vb in -pow2(nb-1) to (pow2(nb-1)-1) loop 
            wait for Tclk;
            for vc in -pow2(nb-1) to (pow2(nb-1)-1) loop
                wait for Tclk+200ns;
                IA<=conv_std_logic_vector(va,nb); --conversione da int a STD_LOGIC, grazie alla funzione presente in ARITH
                IB<=conv_std_logic_vector(vb,nb);
                IC<=conv_std_logic_vector(vc,nb);
                wait for Tclk;
            end loop;  
        end loop;  
    end loop;
end process; 

process
begin
    wait for Tclk/2; 
    Iclk<=not Iclk;
end process; 

end Behavioral;