
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity main is
  Port (
        A:      in std_logic_vector(63 downto 0);
        B:      in std_logic_vector(63 downto 0);
        clk:    in std_logic;
        opera:  in std_logic_vector (1 downto 0);
        result: out std_logic_vector(63 downto 0) 
        );
end main;
 
architecture Behavioral of main is
    component add is
    PORT (        
        A:      in std_logic_vector(63 downto 0);
        B:      in std_logic_vector(63 downto 0);
        clk:    in std_logic;
        result: out std_logic_vector(63 downto 0)
         );
    end component;
   
    component min is
    PORT (        
        A:      in std_logic_vector(63 downto 0);
        B:      in std_logic_vector(63 downto 0);
        clk:    in std_logic;
        result: out std_logic_vector(63 downto 0)
         );
    end component;
   
    component mul is
    PORT (        
        A:      in std_logic_vector(63 downto 0);
        B:      in std_logic_vector(63 downto 0);
        clk:    in std_logic;
        result: out std_logic_vector(63 downto 0)
         );
    end component;
   
    component div is
    PORT (        
        A:      in std_logic_vector(63 downto 0);
        B:      in std_logic_vector(63 downto 0);
        clk:    in std_logic;
        result: out std_logic_vector(63 downto 0)
         );
    end component;
    
    signal result1, result2, result3, result4: std_logic_vector (63 downto 0);

begin

u1: add port map(A, B, clk, result1);
u2: min port map(A, B, clk, result2);
u3: mul port map(A, B, clk, result3);
u4: div port map(A, B, clk, result4);
process (opera,result1,result2,result3,result4)
begin
case opera is 
    when "00" => result <= result1;
    when "01" => result <= result2;
    when "10" => result <= result3;
    when "11" => result <= result4;
    when others => result <= (others => 'X');
end case;
end process;
end Behavioral;
