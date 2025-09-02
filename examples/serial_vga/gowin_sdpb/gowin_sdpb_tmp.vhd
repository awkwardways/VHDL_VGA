--Copyright (C)2014-2025 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--Tool Version: V1.9.11.03 (64-bit)
--Part Number: GW2A-LV18PG256C8/I7
--Device: GW2A-18
--Device Version: C
--Created Time: Sat Aug 23 19:07:14 2025

--Change the instance name and port connections to the signal names
----------Copy here to design--------

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

your_instance_name: Gowin_SDPB
    port map (
        dout => dout,
        clka => clka,
        cea => cea,
        reseta => reseta,
        clkb => clkb,
        ceb => ceb,
        resetb => resetb,
        oce => oce,
        ada => ada,
        din => din,
        adb => adb
    );

----------Copy end-------------------
