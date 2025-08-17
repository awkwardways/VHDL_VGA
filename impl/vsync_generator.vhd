library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity vsync_generator is
  generic (
    LN_COUNT_LENGTH : integer := 10;
    VISIBLE_AREA    : integer := 480;
    FRONT_PORCH     : integer := 10;
    SYNC_PULSE      : integer := 2;
    BACK_PORCH      : integer := 33
  );
  port (
    ln_count : in std_logic_vector(LN_COUNT_LENGTH - 1 downto 0);
    vsync    : out std_logic := '0';
    v_visible : out std_logic;
    clk : in std_logic
  );
end entity;

architecture behavioural of vsync_generator is

begin

  process (ln_count, clk)
  begin
    if rising_edge(clk) then
      if unsigned(ln_count) >= VISIBLE_AREA + FRONT_PORCH and unsigned(ln_count) < VISIBLE_AREA + FRONT_PORCH + SYNC_PULSE then
        vsync <= '1';
      else
        vsync <= '0';
      end if;
      if unsigned(ln_count) < VISIBLE_AREA then
        v_visible <= '1';
      else 
        v_visible <= '0';
      end if;
    end if;
  end process;   

end architecture;