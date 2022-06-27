library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder is
    generic(nb: integer);
    Port ( A : in STD_LOGIC_VECTOR (nb-1 downto 0); --ingresso A
           B : in STD_LOGIC_VECTOR (nb-1 downto 0); --ingresso B
           Cin : in STD_LOGIC; --segnale per Add o Sub
           Sum : out STD_LOGIC_VECTOR (nb downto 0));  --somma algebrica (addizione o sottrazione)
end Adder;

architecture Behavioral of Adder is

signal IA, IB : STD_LOGIC_VECTOR(nb-1 downto 0); 
signal p,g: STD_LOGIC_VECTOR (nb downto 0); --segnali di propagate e generate
signal c: STD_LOGIC_VECTOR (nb+1 downto 0); --segnale di carry

begin

 --    Se Cin=0  --> A + B = A + B = Sum
 --    Se Cin=1  --> A - B =  A + (not(B) + 1) = Sum
 
    IA<= A; 
  
    with Cin select --selettore: 0 = addizione , 1 = sottrazione
        IB<= not (B) when '1',
             B when others;
     
    c(0)<=Cin; 
    p<=(IA(nb-1) xor IB(nb-1))&(IA xor IB); 
    g<=(IA(nb-1) and IB(nb-1))&(IA and IB);
    c(nb+1 downto 1)<=g or (p and c(nb downto 0));
    Sum<=p xor c(nb downto 0); 
end Behavioral;