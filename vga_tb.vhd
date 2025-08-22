library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity vga_tb is
end entity vga_tb;

architecture sim of vga_tb is 

  constant PX_RESTART_COUNT  : integer := 800;
  constant PX_COUNT_LENGTH   : integer := integer(ceil(log2(real(PX_RESTART_COUNT))));

  constant LN_RESTART_COUNT  : integer := 525;
  constant LN_COUNT_LENGTH   : integer := integer(ceil(log2(real(LN_RESTART_COUNT))));
  
  constant HS_VISIBLE_AREA   : integer := 640;
  constant HS_FRONT_PORCH    : integer := 16;
  constant HS_SYNC_PULSE     : integer := 96;
  constant HS_BACK_PORCH     : integer := 48;

  constant VS_VISIBLE_AREA   : integer := 480;
  constant VS_FRONT_PORCH    : integer := 10;
  constant VS_SYNC_PULSE     : integer := 2;
  constant VS_BACK_PORCH     : integer := 33;

  constant VGA_CLK_FREQUENCY : integer := 25e6;
  constant VGA_CLK_PERIOD    : time := 1000 ms / VGA_CLK_FREQUENCY;
  
  signal vga_clk   : std_logic := '1';
  signal px_count  : std_logic_vector(PX_COUNT_LENGTH - 1 downto 0);
  signal ln_count  : std_logic_vector(LN_COUNT_LENGTH - 1 downto 0);
  signal hsync     : std_logic;
  signal vsync     : std_logic;
  signal r         : std_logic_vector(4 downto 0);
  signal g         : std_logic_vector(5 downto 0);
  signal b         : std_logic_vector(4 downto 0);
  signal h_visible : std_logic;
  signal v_visible : std_logic;

begin

  vga_clk <= not vga_clk after VGA_CLK_PERIOD / 2;

  r <= (others => (h_visible and v_visible));
  g <= (others => (h_visible and v_visible));
  b <= (others => (h_visible and v_visible));

  vga: entity work.vga(behavioural)
  generic map (
    PX_RESTART_COUNT => PX_RESTART_COUNT,
    PX_COUNT_LENGTH => PX_COUNT_LENGTH,
    LN_RESTART_COUNT => LN_RESTART_COUNT,
    LN_COUNT_LENGTH => LN_COUNT_LENGTH,
    HS_VISIBLE_AREA => HS_VISIBLE_AREA,
    HS_FRONT_PORCH => HS_FRONT_PORCH,
    HS_SYNC_PULSE => HS_SYNC_PULSE,
    HS_BACK_PORCH => HS_BACK_PORCH,
    VS_VISIBLE_AREA => VS_VISIBLE_AREA,
    VS_FRONT_PORCH => VS_FRONT_PORCH,
    VS_SYNC_PULSE => VS_SYNC_PULSE,
    VS_BACK_PORCH => VS_BACK_PORCH
  )
  port map (
    h_visible => h_visible,
    v_visible => v_visible,
    px_count => px_count,
    ln_count => ln_count,
    hsync => hsync,
    vsync => vsync,
    vga_clk => vga_clk
  );

end architecture;