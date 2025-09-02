--Copyright (C)2014-2025 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--Tool Version: V1.9.11.03 (64-bit)
--Part Number: GW2A-LV18PG256C8/I7
--Device: GW2A-18
--Device Version: C
--Created Time: Sat Aug 30 21:22:18 2025

--Change the instance name and port connections to the signal names
----------Copy here to design--------

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

your_instance_name: Gowin_pROM
    port map (
        dout => dout,
        clk => clk,
        oce => oce,
        ce => ce,
        reset => reset,
        ad => ad
    );

----------Copy end-------------------
