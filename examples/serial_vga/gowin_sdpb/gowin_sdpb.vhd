--Copyright (C)2014-2025 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: IP file
--Tool Version: V1.9.11.03 (64-bit)
--Part Number: GW2A-LV18PG256C8/I7
--Device: GW2A-18
--Device Version: C
--Created Time: Sat Aug 23 19:07:14 2025

library IEEE;
use IEEE.std_logic_1164.all;

entity Gowin_SDPB is
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
end Gowin_SDPB;

architecture Behavioral of Gowin_SDPB is

    signal sdpb_inst_0_dout_w: std_logic_vector(29 downto 0);
    signal sdpb_inst_1_dout_w: std_logic_vector(29 downto 0);
    signal sdpb_inst_2_dout_w: std_logic_vector(29 downto 0);
    signal sdpb_inst_3_dout_w: std_logic_vector(29 downto 0);
    signal gw_gnd: std_logic;
    signal sdpb_inst_0_BLKSELA_i: std_logic_vector(2 downto 0);
    signal sdpb_inst_0_BLKSELB_i: std_logic_vector(2 downto 0);
    signal sdpb_inst_0_ADA_i: std_logic_vector(13 downto 0);
    signal sdpb_inst_0_DI_i: std_logic_vector(31 downto 0);
    signal sdpb_inst_0_ADB_i: std_logic_vector(13 downto 0);
    signal sdpb_inst_0_DO_o: std_logic_vector(31 downto 0);
    signal sdpb_inst_1_BLKSELA_i: std_logic_vector(2 downto 0);
    signal sdpb_inst_1_BLKSELB_i: std_logic_vector(2 downto 0);
    signal sdpb_inst_1_ADA_i: std_logic_vector(13 downto 0);
    signal sdpb_inst_1_DI_i: std_logic_vector(31 downto 0);
    signal sdpb_inst_1_ADB_i: std_logic_vector(13 downto 0);
    signal sdpb_inst_1_DO_o: std_logic_vector(31 downto 0);
    signal sdpb_inst_2_BLKSELA_i: std_logic_vector(2 downto 0);
    signal sdpb_inst_2_BLKSELB_i: std_logic_vector(2 downto 0);
    signal sdpb_inst_2_ADA_i: std_logic_vector(13 downto 0);
    signal sdpb_inst_2_DI_i: std_logic_vector(31 downto 0);
    signal sdpb_inst_2_ADB_i: std_logic_vector(13 downto 0);
    signal sdpb_inst_2_DO_o: std_logic_vector(31 downto 0);
    signal sdpb_inst_3_BLKSELA_i: std_logic_vector(2 downto 0);
    signal sdpb_inst_3_BLKSELB_i: std_logic_vector(2 downto 0);
    signal sdpb_inst_3_ADA_i: std_logic_vector(13 downto 0);
    signal sdpb_inst_3_DI_i: std_logic_vector(31 downto 0);
    signal sdpb_inst_3_ADB_i: std_logic_vector(13 downto 0);
    signal sdpb_inst_3_DO_o: std_logic_vector(31 downto 0);

    --component declaration
    component SDPB
        generic (
            READ_MODE: in bit := '0';
            BIT_WIDTH_0: in integer :=16;
            BIT_WIDTH_1: in integer :=16;
            BLK_SEL_0: in bit_vector := "000";
            BLK_SEL_1: in bit_vector := "000";
            RESET_MODE: in string := "SYNC";
            INIT_RAM_00: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_01: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_02: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_03: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_04: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_05: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_06: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_07: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_08: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_09: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0A: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0B: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0C: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0D: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0E: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0F: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_10: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_11: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_12: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_13: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_14: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_15: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_16: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_17: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_18: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_19: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1A: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1B: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1C: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1D: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1E: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1F: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_20: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_21: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_22: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_23: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_24: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_25: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_26: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_27: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_28: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_29: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2A: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2B: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2C: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2D: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2E: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2F: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_30: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_31: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_32: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_33: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_34: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_35: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_36: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_37: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_38: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_39: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3A: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3B: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3C: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3D: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3E: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3F: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
        );
        port (
            DO: out std_logic_vector(31 downto 0);
            CLKA: in std_logic;
            CEA: in std_logic;
            RESETA: in std_logic;
            CLKB: in std_logic;
            CEB: in std_logic;
            RESETB: in std_logic;
            OCE: in std_logic;
            BLKSELA: in std_logic_vector(2 downto 0);
            BLKSELB: in std_logic_vector(2 downto 0);
            ADA: in std_logic_vector(13 downto 0);
            DI: in std_logic_vector(31 downto 0);
            ADB: in std_logic_vector(13 downto 0)
        );
    end component;

begin
    gw_gnd <= '0';

    sdpb_inst_0_BLKSELA_i <= gw_gnd & gw_gnd & gw_gnd;
    sdpb_inst_0_BLKSELB_i <= gw_gnd & gw_gnd & gw_gnd;
    sdpb_inst_0_ADA_i <= ada(12 downto 0) & gw_gnd;
    sdpb_inst_0_DI_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & din(1 downto 0);
    sdpb_inst_0_ADB_i <= adb(12 downto 0) & gw_gnd;
    dout(1 downto 0) <= sdpb_inst_0_DO_o(1 downto 0) ;
    sdpb_inst_0_dout_w(29 downto 0) <= sdpb_inst_0_DO_o(31 downto 2) ;
    sdpb_inst_1_BLKSELA_i <= gw_gnd & gw_gnd & gw_gnd;
    sdpb_inst_1_BLKSELB_i <= gw_gnd & gw_gnd & gw_gnd;
    sdpb_inst_1_ADA_i <= ada(12 downto 0) & gw_gnd;
    sdpb_inst_1_DI_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & din(3 downto 2);
    sdpb_inst_1_ADB_i <= adb(12 downto 0) & gw_gnd;
    dout(3 downto 2) <= sdpb_inst_1_DO_o(1 downto 0) ;
    sdpb_inst_1_dout_w(29 downto 0) <= sdpb_inst_1_DO_o(31 downto 2) ;
    sdpb_inst_2_BLKSELA_i <= gw_gnd & gw_gnd & gw_gnd;
    sdpb_inst_2_BLKSELB_i <= gw_gnd & gw_gnd & gw_gnd;
    sdpb_inst_2_ADA_i <= ada(12 downto 0) & gw_gnd;
    sdpb_inst_2_DI_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & din(5 downto 4);
    sdpb_inst_2_ADB_i <= adb(12 downto 0) & gw_gnd;
    dout(5 downto 4) <= sdpb_inst_2_DO_o(1 downto 0) ;
    sdpb_inst_2_dout_w(29 downto 0) <= sdpb_inst_2_DO_o(31 downto 2) ;
    sdpb_inst_3_BLKSELA_i <= gw_gnd & gw_gnd & gw_gnd;
    sdpb_inst_3_BLKSELB_i <= gw_gnd & gw_gnd & gw_gnd;
    sdpb_inst_3_ADA_i <= ada(12 downto 0) & gw_gnd;
    sdpb_inst_3_DI_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & din(7 downto 6);
    sdpb_inst_3_ADB_i <= adb(12 downto 0) & gw_gnd;
    dout(7 downto 6) <= sdpb_inst_3_DO_o(1 downto 0) ;
    sdpb_inst_3_dout_w(29 downto 0) <= sdpb_inst_3_DO_o(31 downto 2) ;

    sdpb_inst_0: SDPB
        generic map (
            READ_MODE => '0',
            BIT_WIDTH_0 => 2,
            BIT_WIDTH_1 => 2,
            RESET_MODE => "SYNC",
            BLK_SEL_0 => "000",
            BLK_SEL_1 => "000"
        )
        port map (
            DO => sdpb_inst_0_DO_o,
            CLKA => clka,
            CEA => cea,
            RESETA => reseta,
            CLKB => clkb,
            CEB => ceb,
            RESETB => resetb,
            OCE => oce,
            BLKSELA => sdpb_inst_0_BLKSELA_i,
            BLKSELB => sdpb_inst_0_BLKSELB_i,
            ADA => sdpb_inst_0_ADA_i,
            DI => sdpb_inst_0_DI_i,
            ADB => sdpb_inst_0_ADB_i
        );

    sdpb_inst_1: SDPB
        generic map (
            READ_MODE => '0',
            BIT_WIDTH_0 => 2,
            BIT_WIDTH_1 => 2,
            RESET_MODE => "SYNC",
            BLK_SEL_0 => "000",
            BLK_SEL_1 => "000"
        )
        port map (
            DO => sdpb_inst_1_DO_o,
            CLKA => clka,
            CEA => cea,
            RESETA => reseta,
            CLKB => clkb,
            CEB => ceb,
            RESETB => resetb,
            OCE => oce,
            BLKSELA => sdpb_inst_1_BLKSELA_i,
            BLKSELB => sdpb_inst_1_BLKSELB_i,
            ADA => sdpb_inst_1_ADA_i,
            DI => sdpb_inst_1_DI_i,
            ADB => sdpb_inst_1_ADB_i
        );

    sdpb_inst_2: SDPB
        generic map (
            READ_MODE => '0',
            BIT_WIDTH_0 => 2,
            BIT_WIDTH_1 => 2,
            RESET_MODE => "SYNC",
            BLK_SEL_0 => "000",
            BLK_SEL_1 => "000"
        )
        port map (
            DO => sdpb_inst_2_DO_o,
            CLKA => clka,
            CEA => cea,
            RESETA => reseta,
            CLKB => clkb,
            CEB => ceb,
            RESETB => resetb,
            OCE => oce,
            BLKSELA => sdpb_inst_2_BLKSELA_i,
            BLKSELB => sdpb_inst_2_BLKSELB_i,
            ADA => sdpb_inst_2_ADA_i,
            DI => sdpb_inst_2_DI_i,
            ADB => sdpb_inst_2_ADB_i
        );

    sdpb_inst_3: SDPB
        generic map (
            READ_MODE => '0',
            BIT_WIDTH_0 => 2,
            BIT_WIDTH_1 => 2,
            RESET_MODE => "SYNC",
            BLK_SEL_0 => "000",
            BLK_SEL_1 => "000"
        )
        port map (
            DO => sdpb_inst_3_DO_o,
            CLKA => clka,
            CEA => cea,
            RESETA => reseta,
            CLKB => clkb,
            CEB => ceb,
            RESETB => resetb,
            OCE => oce,
            BLKSELA => sdpb_inst_3_BLKSELA_i,
            BLKSELB => sdpb_inst_3_BLKSELB_i,
            ADA => sdpb_inst_3_ADA_i,
            DI => sdpb_inst_3_DI_i,
            ADB => sdpb_inst_3_ADB_i
        );

end Behavioral; --Gowin_SDPB
