library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shifter is
    Port ( d_in : in STD_LOGIC_VECTOR (15 downto 0);
           d_out : out STD_LOGIC_VECTOR (11 downto 0));
end Shifter;

architecture Behavioral of Shifter is

begin

d_out <= d_in(15 downto 4);

end Behavioral;
