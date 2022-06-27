library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity Registro is
    generic(nb : integer);
    Port ( D : in STD_LOGIC_VECTOR(nb-1 downto 0); --ingresso del registro
           clk : in STD_LOGIC; --segnale di clock
           Q : out STD_LOGIC_VECTOR(nb-1 downto 0)); --uscita del registro
end Registro;

architecture Behavioral of Registro is 
begin
    process(clk)
    begin
        if falling_edge(clk) then --fronte di discesa del clock
            Q<=D;
        end if;
    end process;
    
end Behavioral;