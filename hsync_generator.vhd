library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity hsync_generator is
  generic (
    PX_COUNT_LENGTH : integer := 10;
    VISIBLE_AREA    : integer := 640;
    FRONT_PORCH     : integer := 16;
    SYNC_PULSE      : integer := 96;
    BACK_PORCH      : integer := 48
  );
  port (
    px_count : in std_logic_vector(PX_COUNT_LENGTH - 1 downto 0);
    hsync    : out std_logic := '0';
    h_visible : out std_logic;
    clk : in std_logic
  );
end entity;

architecture behavioural of hsync_generator is

begin

  process (px_count, clk)
  begin
    if rising_edge(clk) then
      if unsigned(px_count) >= VISIBLE_AREA + FRONT_PORCH and unsigned(px_count) < VISIBLE_AREA + FRONT_PORCH + SYNC_PULSE then
        hsync <= '1';
      else
        hsync <= '0';
      end if;
      if unsigned(px_count) < VISIBLE_AREA then
        h_visible <= '1';
      else
        h_visible <= '0';
      end if;
    end if;
  end process;  

end architecture; 