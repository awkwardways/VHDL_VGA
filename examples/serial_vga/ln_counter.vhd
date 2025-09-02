library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

entity ln_counter is
generic (
  LN_RESTART_COUNT : integer := 525;
  PX_RESTART_COUNT : integer := 800; 
  LN_COUNT_LENGTH  : integer := 10;
  PX_COUNT_LENGTH  : integer := 10
);
port (
  clk_in     : in std_logic;
  ln_count   : out std_logic_vector(LN_COUNT_LENGTH - 1 downto 0) := (others => '0');
  px_count   : in std_logic_vector(PX_COUNT_LENGTH - 1 downto 0)
);
end entity ln_counter;

architecture behavioural of ln_counter is
  signal count : std_logic_vector(LN_COUNT_LENGTH - 1 downto 0) := (others => '0'); 
begin

  process(px_count, clk_in)
  begin
    if rising_edge(clk_in) and unsigned(px_count) = PX_RESTART_COUNT - 1 then
      ln_count <= count;
      count <= std_logic_vector(unsigned(count) + 1);
      if unsigned(count) = LN_RESTART_COUNT - 1 then
        count <= (others => '0');
      end if;
    end if;
  end process;
end architecture behavioural;