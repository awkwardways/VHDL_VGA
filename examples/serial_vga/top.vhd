library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity top is
port (
  hsync      : out std_logic;
  vsync      : out std_logic;
  r          : out std_logic;
  g          : out std_logic;
  b          : out std_logic;
  rx         : in std_logic;
  system_clk : in std_logic
);
end entity top;

architecture behavioural of top is

  constant PX_RESTART_COUNT  : integer := 800;
  constant PX_COUNT_LENGTH   : integer := integer(ceil(log2(real(PX_RESTART_COUNT))));
  constant LN_RESTART_COUNT  : integer := 525;
  constant LN_COUNT_LENGTH   : integer := integer(ceil(log2(real(LN_RESTART_COUNT))));
  constant DATA_BUS_LENGTH   : integer := 8;
  constant HS_VISIBLE_AREA   : integer := 640;
  constant HS_FRONT_PORCH    : integer := 16;
  constant HS_SYNC_PULSE     : integer := 96;
  constant HS_BACK_PORCH     : integer := 48;
  constant VS_VISIBLE_AREA   : integer := 480;
  constant VS_FRONT_PORCH    : integer := 10;
  constant VS_SYNC_PULSE     : integer := 2;
  constant VS_BACK_PORCH     : integer := 33;
  constant SYSTEM_CLOCK_FREQUENCY : integer := 27e6;
  constant BAUDS_FREQUENCY : integer := 9600;

  signal vga_clk          : std_logic;
  signal h_visible        : std_logic;
  signal v_visible        : std_logic;
  signal px_count         : std_logic_vector(PX_COUNT_LENGTH - 1 downto 0);
  signal ln_count         : std_logic_vector(LN_COUNT_LENGTH - 1 downto 0);
  signal data_bus         : std_logic_vector(0 downto 0); 
  signal vga_ram_data_bus : std_logic_vector(DATA_BUS_LENGTH - 1 downto 0);
  signal uart_data_out    : std_logic_vector(DATA_BUS_LENGTH - 1 downto 0); 
  signal bauds            : std_logic;
  signal msgstb           : std_logic;
  signal uart_address     : std_logic_vector(12 downto 0);

  -- Delayed signals
  signal vsync_d : std_logic;
  signal hsync_d : std_logic;
  signal vvis_d  : std_logic;
  signal hvis_d  : std_logic;

  component Gowin_rPLL is
  port (
    clkout: out std_logic;
    clkoutd: out std_logic;
    clkin: in std_logic
  );
  end component;

  component Gowin_pROM
  port (
    dout: out std_logic_vector(0 downto 0);
    clk: in std_logic;
    oce: in std_logic;
    ce: in std_logic;
    reset: in std_logic;
    ad: in std_logic_vector(12 downto 0)
  );
  end component;

  component Gowin_SDPB
  port (
    dout: out std_logic_vector(7 downto 0);
    clka: in std_logic;
    cea: in std_logic;
    reseta: in std_logic;
    clkb: in std_logic;
    ceb: in std_logic;
    resetb: in std_logic;
    oce: in std_logic;
    ada: in std_logic_vector(12 downto 0);
    din: in std_logic_vector(7 downto 0);
    adb: in std_logic_vector(12 downto 0)
  );
  end component;

begin
  -- Drive rgb lines
  r <= data_bus(0) and (h_visible and v_visible);
  g <= data_bus(0) and (h_visible and v_visible);
  b <= data_bus(0) and (h_visible and v_visible);

  clock_divider: entity work.clock_divider(rtl)
  generic map (
    input_clock_frequency => SYSTEM_CLOCK_FREQUENCY,
    output_clock_frequency => BAUDS_FREQUENCY
  )
  port map (
    clock_in => system_clk,
    clock_out => bauds
  );

  uart: entity work.uart(rtl)
  generic map (
    output_bus_width => DATA_BUS_LENGTH
  )
  port map (
    data_in => (others => '0'),
    data_out => uart_data_out,
    tx => open,
    rx => rx,
    wrn => '1',
    rdn => '0',
    ctsn => '1',
    bauds => bauds,
    msgstb => msgstb
  );

  uart_addu : entity work.uart_addu(behavioural)
  generic map (
    ADDRESS_WIDTH => 13,
    MAX_ADDRESS => 4800
  )
  port map (
    clk_in => bauds,
    address => uart_address,
    enable => msgstb
  );

  rpll: Gowin_rPLL
  port map (
    clkout => open,
    clkoutd => vga_clk,
    clkin => system_clk
  );

  vgaram: Gowin_SDPB
  port map (
    dout => vga_ram_data_bus,
    clka => bauds,
    cea => msgstb,
    reseta => '0',
    clkb => vga_clk,
    ceb => h_visible and v_visible,
    resetb => '0',
    oce => h_visible and v_visible,
    ada => uart_address,
    din => uart_data_out,
    adb => ln_count(8 downto 3) & px_count(9 downto 3)
  );

  fontrom: Gowin_pROM
  port map (
    dout => data_bus,
    clk => vga_clk,
    oce => h_visible and v_visible,
    ce => h_visible and v_visible,
    reset => '0',
    ad => vga_ram_data_bus(6 downto 0) & ln_count(2 downto 0) & px_count(2 downto 0)
  );

  vga: entity work.vga(behavioural)
  generic map (
    PX_RESTART_COUNT => PX_RESTART_COUNT,
    PX_COUNT_LENGTH  => PX_COUNT_LENGTH,
    LN_RESTART_COUNT => LN_RESTART_COUNT,
    LN_COUNT_LENGTH  => LN_COUNT_LENGTH,
    HS_VISIBLE_AREA  => HS_VISIBLE_AREA,
    HS_FRONT_PORCH   => HS_FRONT_PORCH,
    HS_SYNC_PULSE    => HS_SYNC_PULSE,
    HS_BACK_PORCH    => HS_BACK_PORCH,
    VS_VISIBLE_AREA  => VS_VISIBLE_AREA,
    VS_FRONT_PORCH   => VS_FRONT_PORCH,
    VS_SYNC_PULSE    => VS_SYNC_PULSE,
    VS_BACK_PORCH    => VS_BACK_PORCH
  )
  port map (
    h_visible => h_visible,
    v_visible => v_visible,
    px_count  => px_count,
    ln_count  => ln_count,
    hsync     => hsync,
    vsync     => vsync,
    vga_clk   => vga_clk
  );
end architecture behavioural;