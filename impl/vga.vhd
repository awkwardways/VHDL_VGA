library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity vga is
port (
  hsync      : out std_logic;
  vsync      : out std_logic;
  r          : out std_logic_vector(4 downto 0);
  g          : out std_logic_vector(5 downto 0);
  b          : out std_logic_vector(4 downto 0);
  system_clk : in std_logic
);
end entity vga;

architecture behavioural of vga is 

  component Gowin_rPLL is
  port (
    clkout: out std_logic;
    clkoutd: out std_logic;
    clkin: in std_logic
  );
  end component;

  component Gowin_pROM
  port (
    dout: out std_logic_vector(15 downto 0);
    clk: in std_logic;
    oce: in std_logic;
    ce: in std_logic;
    reset: in std_logic;
    ad: in std_logic_vector(14 downto 0)
  );
  end component;

  constant DATA_BUS_WIDTH        : integer := 16;
  constant SCREEN_WIDTH          : integer := 640;
  constant SCREEN_HEIGHT         : integer := 480;
  constant PX_RESTART_COUNT      : integer := 800;
  constant LN_RESTART_COUNT      : integer := 525;
  constant PX_COUNT_LENGTH       : integer := integer(ceil(log2(real(PX_RESTART_COUNT))));
  constant LN_COUNT_LENGTH       : integer := integer(ceil(log2(real(LN_RESTART_COUNT))));
  constant HS_VISIBLE_AREA       : integer := SCREEN_WIDTH;
  constant HS_FRONT_PORCH        : integer := 16;
  constant HS_SYNC_PULSE         : integer := 96;
  constant HS_BACK_PORCH         : integer := 48;
  constant VS_VISIBLE_AREA       : integer := SCREEN_HEIGHT;
  constant VS_FRONT_PORCH        : integer := 10;
  constant VS_SYNC_PULSE         : integer := 2;
  constant VS_BACK_PORCH         : integer := 33;
  constant ADDRESS_BUS_WIDTH     : integer := integer(ceil(log2(real((SCREEN_WIDTH * SCREEN_HEIGHT)))));
  
  signal vga_clk     : std_logic;
  signal ln_enable   : std_logic;  
  signal px_count    : std_logic_vector(PX_COUNT_LENGTH - 1 downto 0);
  signal ln_count    : std_logic_vector(LN_COUNT_LENGTH - 1 downto 0);
  signal address_bus : std_logic_vector(ADDRESS_BUS_WIDTH - 1 downto 0);
  signal data_bus    : std_logic_vector(DATA_BUS_WIDTH - 1 downto 0);
  signal h_visible   : std_logic;
  signal v_visible   : std_logic;
  signal rom_select  : std_logic;
  signal hsync_d     : std_logic;

begin
  r <= data_bus(DATA_BUS_WIDTH - 1 downto 11) and (h_visible and v_visible);
  g <= data_bus(10 downto 5) and (h_visible and v_visible);
  b <= data_bus(4 downto 0) and (h_visible and v_visible);

  rpll: Gowin_rPLL
  port map (
    clkout => open,
    clkoutd => vga_clk,
    clkin => system_clk
  );

  pixelcounter: entity work.px_counter(behavioural)
  generic map (
    RESTART_COUNT => PX_RESTART_COUNT,
    PX_COUNT_LENGTH => PX_COUNT_LENGTH
  )
  port map (
    clk_in => vga_clk,
    px_count => px_count
  );

  linecounter: entity work.ln_counter(behavioural)
  generic map (
    LN_RESTART_COUNT => LN_RESTART_COUNT,
    PX_RESTART_COUNT => PX_RESTART_COUNT,
    PX_COUNT_LENGTH => PX_COUNT_LENGTH,
    LN_COUNT_LENGTH => LN_COUNT_LENGTH
  )
  port map (
    clk_in => vga_clk,
    ln_count => ln_count,
    px_count => px_count
  );

  hsyncgenerator: entity work.hsync_generator(behavioural)
  generic map (
    PX_COUNT_LENGTH => PX_COUNT_LENGTH,
    VISIBLE_AREA => HS_VISIBLE_AREA,
    FRONT_PORCH => HS_FRONT_PORCH,
    SYNC_PULSE => HS_SYNC_PULSE,
    BACK_PORCH => HS_BACK_PORCH 
  )
  port map (
    px_count => px_count, 
    hsync => hsync,
    h_visible => h_visible,
    clk => vga_clk
  );


  vsyncgenerator: entity work.vsync_generator(behavioural)
  generic map (
    LN_COUNT_LENGTH => LN_COUNT_LENGTH,
    VISIBLE_AREA => VS_VISIBLE_AREA,
    FRONT_PORCH => VS_FRONT_PORCH,
    SYNC_PULSE => VS_SYNC_PULSE,
    BACK_PORCH => VS_BACK_PORCH
  )
  port map (
    vsync => vsync,
    ln_count => ln_count,
    v_visible => v_visible,
    clk => vga_clk
  );

  rom: Gowin_pROM
  port map (
    dout => data_bus,
    clk => vga_clk,
    oce => '1',
    ce => h_visible and v_visible,
    reset => '0',
    ad => ln_count(8 downto 2) & px_count(9 downto 2) 
  );

end architecture;