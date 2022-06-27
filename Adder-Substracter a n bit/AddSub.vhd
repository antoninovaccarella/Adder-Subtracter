library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work; --directory in cui si trova il progetto attuale
use work.myconst.all; --per la costante nbitin (dichiarata in support)
 
entity AddSub is
    generic(nb : integer:=nbitin);
    Port ( A : in STD_LOGIC_VECTOR(nb-1 downto 0); --ingresso A
           B : in STD_LOGIC_VECTOR(nb-1 downto 0); --ingresso B
           C : in STD_LOGIC_VECTOR(nb-1 downto 0); --ingresso C
           clk : in STD_LOGIC; --segnale di clock
           Ris : out STD_LOGIC_VECTOR(nb+1 downto 0)); --somma algebrica (addizione e sottrazione)
end AddSub;
 
architecture Behavioral of AddSub is
 
signal RA,RB : STD_LOGIC_VECTOR(nb-1 downto 0); --segnali dei registri A e B
signal nC, RC : STD_LOGIC_VECTOR(nb downto 0); -- segnale di C esteso (nuovo C) e del registro C
signal PSum, RPSum : STD_LOGIC_VECTOR(nb downto 0); --segnali della Somma Parziale e del rispettivo registro
signal ORis : STD_LOGIC_VECTOR(nb+1 downto 0); --segnale del risultato finale

component Registro is 
    generic(nb : integer);
    Port(D : in STD_LOGIC_VECTOR(nb-1 downto 0);
         clk : in STD_LOGIC;
         Q : out STD_LOGIC_VECTOR(nb-1 downto 0));
end component;
 
component Adder is 
    generic(nb : integer);
    Port(A : in STD_LOGIC_VECTOR(nb-1 downto 0);
         B : in STD_LOGIC_VECTOR(nb-1 downto 0);
         Cin : in STD_LOGIC;
         Sum : out STD_LOGIC_VECTOR(nb downto 0));
end component;


begin
--Registro A
    RegA : Registro 
        generic map(nb) 
        port map(A, clk, RA); --Operando A
--Registro B   
    RegB : Registro
        generic map(nb) 
        port map(B, clk, RB); --Operando B
        
    nC<=(C(nb-1)&C); --estensione di C di un bit
--Registro C
    RegC : Registro 
        generic map(nb+1) 
        port map(nC,clk,RC); --Operando C    
--Addizione
    Add : Adder
        generic map(nb) 
        port map(RA,RB,'0',PSum); -- A+B= SommaParziale
        
--Registro della somma parziale
    RegPSum : Registro
        generic map(nb+1)
        port map(PSum,clk,RPSum);     
    
--Sottrazione    
    Sub : Adder
        generic map(nb+1) 
        port map(RPSum,RC,'1',ORis); --SommaParziale + (-C)   
        
--Registro del risultato
    RegRis : Registro 
        generic map(nb+2)
        port map(ORis,clk,Ris); --Risultato finale

end Behavioral;