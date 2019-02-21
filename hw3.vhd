----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2019 01:56:48 PM
-- Design Name: 
-- Module Name: mux2t1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux2t1 is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           m_out : out STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC);
end mux2t1;

architecture Behavioral of mux2t1 is
begin
with sel select
m_out <= A when '1',
         B when '0',
         (others => '0') when others;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4t1 is
    Port ( A, B, C, D : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           m_out : out STD_LOGIC_VECTOR (7 downto 0));
end mux4t1;

architecture Behavioral of mux4t1 is
begin
with sel select
m_out <= A when "11",
         B when "10",
         C when "01",
         D when "00",
         (others => '0') when others;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec is
    Port ( A, B: out STD_LOGIC;
           sel : in STD_LOGIC);         
end dec;

architecture Behavioral of dec is
begin
    a <= '0' when sel = '0' else
         '1' when sel = '1';
    B <= '1' when sel = '0' else
         '0' when sel = '1';
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg8 is
    Port( reg_in : in std_logic_vector(7 downto 0);
          ld, clk :in std_logic;
          reg_out : out std_logic_vector(7 downto 0));
end reg8;

architecture Behavioral of reg8 is
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(ld = '1') then
                reg_out <= reg_in;
            end if;
        end if;
    end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ckt1 is
    port( D1_IN,D2_IN : in std_logic_vector(7 downto 0);
          CLK,SEL : in std_logic;
          LD : in std_logic;
          reg_out : out std_logic_vector(7 downto 0));
end ckt1;

architecture structure of ckt1 is
    component mux2t1
        port ( A,B : in std_logic_vector(7 downto 0);
               SEL : in std_logic;
               M_OUT : out std_logic_vector(7 downto 0));
    end component;
    component reg8
        Port ( REG_IN : in std_logic_vector(7 downto 0);
               LD,CLK : in std_logic;
               REG_OUT : out std_logic_vector(7 downto 0));
    end component;
    signal muxout : std_logic_vector(7 downto 0);
begin
    REG: reg8
    port map( Reg_in => muxout,
              ld => ld,
              clk => clk,
              reg_out => reg_out);
    mux: mux2t1
    port map( A => D1_in,
              B => D2_in,
              sel => sel,
              m_out => muxout);                            
end structure;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ckt2 is
    port( D1,D2, D3 : in std_logic_vector(7 downto 0);
          CLK, DS : in std_logic;
          ms : in std_logic_vector(1 downto 0);
          reg_out : inout std_logic_vector(7 downto 0));
end ckt2;

architecture structure of ckt2 is
    component mux4t1
        port ( A,B,C,D : in std_logic_vector(7 downto 0);
               SEL : in std_logic_vector(1 downto 0);
               M_OUT : out std_logic_vector(7 downto 0));
    end component;
    component reg8
        Port ( REG_IN : in std_logic_vector(7 downto 0);
               LD,CLK : in std_logic;
               REG_OUT : out std_logic_vector(7 downto 0));
    end component;
    component dec
    Port ( A, B: out STD_LOGIC;
           sel : in STD_LOGIC);         
    end component;
    signal muxout : std_logic_vector(7 downto 0);
    signal regout : std_logic_vector(7 downto 0);
    signal lda, ldb : std_logic;
begin
    REGB: reg8
    port map( Reg_in => regout,
              ld => ldb,
              clk => clk,
              reg_out => reg_out);
    REGA: reg8
    port map( Reg_in => muxout,
              ld => lda,
              clk => clk,
              reg_out => regout);
    dec1: dec
    port map( A => lda,
              B => ldb,
              sel => DS);
    mux: mux4t1
    port map( A => D1,
              B => D2,
              C => D3,
              D => reg_out,
              sel => MS,
              m_out => muxout);                            
end structure;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ckt3 is
    port( X, Y : in std_logic_vector(7 downto 0);
          lda, ldb : in std_logic;
          S1, S0, clk : in std_logic;
          reg_out : inout std_logic_vector(7 downto 0));
end ckt3;

architecture structure of ckt3 is
    component mux2t1
    port ( A,B : in std_logic_vector(7 downto 0);
           SEL : in std_logic;
           M_OUT : out std_logic_vector(7 downto 0));
    end component;
    component reg8
        Port ( REG_IN : in std_logic_vector(7 downto 0);
               LD,CLK : in std_logic;
               REG_OUT : out std_logic_vector(7 downto 0));
    end component;
    signal mux1_out, regA_out, mux2_out : std_logic_vector(7 downto 0);
begin
    mux1: mux2t1
       port map( A => X,
                 B => reg_out,
                 sel => S1,
                 m_out => mux1_out);
   mux2: mux2t1
       port map( A => rega_out,
                 B => Y,
                 sel => S0,
                 m_out => mux2_out);
   rega: reg8
       port map( reg_in => mux1_out,
                 clk => clk,
                 LD => lda,
                 reg_out => rega_out);
   regb: reg8
       port map( reg_in => mux2_out,
                 clk => clk,
                 LD => ldb,
                 reg_out => reg_out);                 
end structure;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ckt4 is
    port( X, Y : in std_logic_vector(7 downto 0);
          lda, ldb : in std_logic;
          S1, S0, RD, clk : in std_logic;
          RB : inout std_logic_vector(7 downto 0); 
          RA : out std_logic_vector(7 downto 0));
end ckt4;

architecture structure of ckt4 is
    component mux2t1
    port ( A,B : in std_logic_vector(7 downto 0);
           SEL : in std_logic;
           M_OUT : out std_logic_vector(7 downto 0));
    end component;
    component reg8
        Port ( REG_IN : in std_logic_vector(7 downto 0);
               LD,CLK : in std_logic;
               REG_OUT : out std_logic_vector(7 downto 0));
    end component;
    signal mux1_out, mux2_out : std_logic_vector(7 downto 0);
    signal ld1, ld2 : std_logic;
begin
    mux1: mux2t1
    port map( A => X,
              B => Y,
              sel => s1,
              m_out => mux1_out);
    mux2: mux2t1
    port map( A => RB,
              B => Y,
              sel => s0,
              m_out => mux1_out); 
    rega: reg8
    port map(reg_in => mux1_out,
             clk => clk,
             reg_out => RA,
             ld =>  ld1);
    ld1 <= lda and RD;
    regb: reg8
    port map(reg_in => mux2_out,
             clk => clk,
             reg_out => RB,
             ld =>  ld2); 
    ld2 <= ldb and not(RD);           
end Structure;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ckt5 is
    port( A, B, C : in std_logic_vector(7 downto 0);
          sl1, sl2, clk : in std_logic;
          rax, rbx : out std_logic_vector(7 downto 0));
          
end ckt5;

architecture structure of ckt5 is
    component mux2t1
        port ( A,B : in std_logic_vector(7 downto 0);
               SEL : in std_logic;
               M_OUT : out std_logic_vector(7 downto 0));
    end component;
    component reg8
        Port ( REG_IN : in std_logic_vector(7 downto 0);
               LD,CLK : in std_logic;
               REG_OUT : out std_logic_vector(7 downto 0));
    end component;
    component dec
    Port ( A, B: out STD_LOGIC;
           sel : in STD_LOGIC);         
    end component;
    signal lda, ldb : std_logic;
    signal mux_out : std_logic_vector(7 downto 0);
 begin
    mux1: mux2t1
    port map( A => B,
              B => C,
              sel => sl2,
              m_out => mux_out);
   dec1: dec
   port map(sel => sl1,
            a => lda,
            b => ldb);
   rega: reg8
   port map(clk => clk,
            reg_in => A,
            ld => lda,
            reg_out => rax);
   regb: reg8
   port map(clk => clk,
            reg_in => mux_out,
            ld => ldb,
            reg_out => rbx);             
 
 end structure;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ckt6 is
    port( A, B, C : in std_logic_vector(7 downto 0);
          sl1, sl2, clk : in std_logic;
          rap, rbp : out std_logic_vector(7 downto 0));
          
end ckt6;

architecture structure of ckt6 is
    component mux2t1
        port ( A,B : in std_logic_vector(7 downto 0);
               SEL : in std_logic;
               M_OUT : out std_logic_vector(7 downto 0));
    end component;
    component reg8
        Port ( REG_IN : in std_logic_vector(7 downto 0);
               LD,CLK : in std_logic;
               REG_OUT : out std_logic_vector(7 downto 0));
    end component;
    component dec
    Port ( A, B: out STD_LOGIC;
           sel : in STD_LOGIC);         
    end component;
    signal lda, ldb : std_logic;
    signal mux_out : std_logic_vector(7 downto 0);
 begin
    mux1: mux2t1
    port map( A => A,
              B => B,
              sel => sl1,
              m_out => mux_out);
   dec1: dec
   port map(sel => sl2,
            a => lda,
            b => ldb);
   rega: reg8
   port map(clk => clk,
            reg_in => mux_out,
            ld => lda,
            reg_out => rap);
   regb: reg8
   port map(clk => clk,
            reg_in => C,
            ld => ldb,
            reg_out => rbp);             
 
 end structure;