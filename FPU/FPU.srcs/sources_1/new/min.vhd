library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all; 
use ieee.numeric_bit.all;


entity min is
Port (
        A:      in std_logic_vector(63 downto 0);
        B:      in std_logic_vector(63 downto 0);
        clk:    in std_logic;
        result: out std_logic_vector(63 downto 0) 
      );
end min;

architecture Behavioral of min is

signal res_sign:    std_logic;
signal res_exp:     std_logic_vector(63 downto 53);
signal res_mes:     std_logic_vector(52 downto 0);
signal res_mes_ex:  bit_vector(104 downto 0);
signal A_sign:      std_logic;
signal A_exp:       std_logic_vector(63 downto 53);
signal A_mes:       std_logic_vector(52 downto 0);
signal A_mes_ex:    bit_vector (104 downto 0);
signal B_sign:      std_logic;
signal B_exp:       std_logic_vector(63 downto 53);
signal B_mes:       std_logic_vector(52 downto 0);
signal B_mes_ex:    bit_vector(104 downto 0);
signal compv:       std_logic_vector(10 downto 0);
signal comp:        integer;

begin
A_sign <= A(63);
A_exp  <= A(62 downto 52);
A_mes(51 downto 0)  <= A(51 downto 0);
A_mes(52) <= '1';
A_mes_ex(52 downto 0)  <= to_bitvector(A_mes(52 downto 0));
A_mes_ex(104 downto 53)  <= "0000000000000000000000000000000000000000000000000000";
B_sign <= B(63);
B_exp  <= B(62 downto 52);
B_mes(51 downto 0)  <= B(51 downto 0);
B_mes(52) <= '1';
B_mes_ex(52 downto 0)  <= to_bitvector(B_mes(52 downto 0));
B_mes_ex(104 downto 53)  <= "0000000000000000000000000000000000000000000000000000";
compv <= A_exp - B_exp;
comp <= conv_integer(compv);


process (A_sign, A_exp, A_mes, A_mes_ex, B_sign, B_exp, B_mes, B_mes_ex, compv, comp, clk) is
begin
    if clk = '1' then
    
            if compv(10) = '0' then
              A_mes_ex <= A_mes_ex sll comp;
              res_exp <= A_exp;
              
            elsif compv(10) = '1' then
                compv <= B_exp - A_exp;
                comp <= conv_integer(compv);
                B_mes_ex <= B_mes_ex sll comp;
                res_exp <= B_exp;
            end if;
            
            res_mes_ex <= to_bitvector(to_stdlogicvector(A_mes_ex) - to_stdlogicvector(B_mes_ex));
            
            if res_mes_ex (104 downto 54) /= "000000000000000000000000000000000000000000000000000" then
               res_mes_ex <= res_mes_ex srl 1;
               res_exp <= res_exp + 1;
            elsif res_mes_ex (53) = '0' then
               res_mes_ex <= res_mes_ex sll 1;
               res_exp <= res_exp - 1;
            elsif res_mes_ex (104 downto 54) = "000000000000000000000000000000000000000000000000000" then
               res_mes <= to_stdlogicvector(res_mes_ex(52 downto 0));
            end if;
        result(63)              <= A_sign xor B_sign;
        result(62 downto 52)    <= res_exp;
        result(51 downto 0)     <= res_mes(51 downto 0);
    end if;
end process;

end Behavioral;
