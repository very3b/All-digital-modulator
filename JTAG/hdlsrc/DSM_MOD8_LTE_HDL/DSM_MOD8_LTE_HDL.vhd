-- -------------------------------------------------------------
-- 
-- File Name: hdlsrc\DSM_MOD8_LTE_HDL\DSM_MOD8_LTE_HDL.vhd
-- Created: 2018-01-07 05:09:03
-- 
-- Generated by MATLAB 8.2 and HDL Coder 3.3
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 3.33333e-07
-- Target subsystem base rate: 3.33333e-07
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        3.33333e-07
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- Out1                          ce_out        3.33333e-07
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: DSM_MOD8_LTE_HDL
-- Source Path: DSM_MOD8_LTE_HDL
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY DSM_MOD8_LTE_HDL IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        In1                               :   IN    std_logic_vector(35 DOWNTO 0);  -- sfix36_En35
        ce_out                            :   OUT   std_logic;
        Out1                              :   OUT   std_logic_vector(35 DOWNTO 0)  -- sfix36
        );
END DSM_MOD8_LTE_HDL;


ARCHITECTURE rtl OF DSM_MOD8_LTE_HDL IS

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL Digital_PCM_signal               : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain24_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain28_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain18_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain15_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain8_out1                       : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain7_out1                       : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain6_out1                       : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain5_out1                       : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain_mul_temp                    : signed(71 DOWNTO 0);  -- sfix72_En70
  SIGNAL Gain_out1                        : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Data_Type_Conversion1_out1       : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain25_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En70
  SIGNAL Gain25_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum15_out1                       : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Delay6_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain23_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En72
  SIGNAL Gain23_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain19_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En74
  SIGNAL Gain19_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum9_out1                        : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Delay4_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain17_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En77
  SIGNAL Gain17_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain4_mul_temp                   : signed(71 DOWNTO 0);  -- sfix72_En79
  SIGNAL Gain4_out1                       : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum5_out1                        : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Delay2_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain3_mul_temp                   : signed(71 DOWNTO 0);  -- sfix72_En84
  SIGNAL Gain3_out1                       : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain2_mul_temp                   : signed(71 DOWNTO 0);  -- sfix72_En86
  SIGNAL Gain2_out1                       : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum1_out1                        : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Delay_out1                       : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Modulator_output                 : signed(35 DOWNTO 0);  -- sfix36
  SIGNAL Gain1_mul_temp                   : signed(71 DOWNTO 0);  -- sfix72_En92
  SIGNAL Gain1_out1                       : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Delay1_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain9_mul_temp                   : signed(71 DOWNTO 0);  -- sfix72_En70
  SIGNAL Gain9_out1                       : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum_op_stage2                    : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum_out1                         : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain14_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En70
  SIGNAL Gain14_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum1_add_temp                    : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum2_op_stage2                   : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum2_out1                        : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain13_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En70
  SIGNAL Gain13_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum3_out1                        : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Delay3_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain10_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En70
  SIGNAL Gain10_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum4_op_stage2                   : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum4_op_stage3                   : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum4_out1                        : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain12_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En70
  SIGNAL Gain12_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum6_op_stage2                   : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum6_out1                        : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain11_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En70
  SIGNAL Gain11_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum7_out1                        : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Delay5_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain20_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En70
  SIGNAL Gain20_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum8_op_stage2                   : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum8_op_stage3                   : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum8_out1                        : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain16_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En70
  SIGNAL Gain16_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum10_op_stage2                  : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum10_out1                       : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain21_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En70
  SIGNAL Gain21_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum11_out1                       : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Delay7_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain26_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En70
  SIGNAL Gain26_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum14_op_stage2                  : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum14_op_stage3                  : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum14_out1                       : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain22_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En70
  SIGNAL Gain22_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum12_op_stage2                  : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum12_out1                       : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Gain27_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En70
  SIGNAL Gain27_out1                      : signed(35 DOWNTO 0);  -- sfix36_En35
  SIGNAL Sum13_out1                       : signed(35 DOWNTO 0);  -- sfix36_En35

BEGIN
  Digital_PCM_signal <= signed(In1);

  Gain24_out1 <= to_signed(0, 36);

  Gain28_out1 <= to_signed(0, 36);

  Gain18_out1 <= to_signed(0, 36);

  Gain15_out1 <= to_signed(0, 36);

  Gain8_out1 <= to_signed(0, 36);

  Gain7_out1 <= to_signed(0, 36);

  Gain6_out1 <= to_signed(0, 36);

  Gain5_out1 <= to_signed(0, 36);

  Gain_mul_temp <= to_signed(5137, 36) * Digital_PCM_signal;
  Gain_out1 <= Gain_mul_temp(70 DOWNTO 35);

  enb <= clk_enable;

  Gain25_mul_temp <= signed'(X"491FC4622") * Data_Type_Conversion1_out1;
  Gain25_out1 <= Gain25_mul_temp(70 DOWNTO 35);

  Delay6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay6_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay6_out1 <= Sum15_out1;
      END IF;
    END IF;
  END PROCESS Delay6_process;


  Gain23_mul_temp <= signed'(X"67B091812") * Data_Type_Conversion1_out1;
  Gain23_out1 <= resize(Gain23_mul_temp(71 DOWNTO 37), 36);

  Gain19_mul_temp <= signed'(X"5BBD4B284") * Data_Type_Conversion1_out1;
  Gain19_out1 <= resize(Gain19_mul_temp(71 DOWNTO 39), 36);

  Delay4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay4_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay4_out1 <= Sum9_out1;
      END IF;
    END IF;
  END PROCESS Delay4_process;


  Gain17_mul_temp <= signed'(X"4BF3D56B3") * Data_Type_Conversion1_out1;
  Gain17_out1 <= resize(Gain17_mul_temp(71 DOWNTO 42), 36);

  Gain4_mul_temp <= signed'(X"45E224032") * Data_Type_Conversion1_out1;
  Gain4_out1 <= resize(Gain4_mul_temp(71 DOWNTO 44), 36);

  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay2_out1 <= Sum5_out1;
      END IF;
    END IF;
  END PROCESS Delay2_process;


  Gain3_mul_temp <= signed'(X"6F7E38959") * Data_Type_Conversion1_out1;
  Gain3_out1 <= resize(Gain3_mul_temp(71 DOWNTO 49), 36);

  Gain2_mul_temp <= signed'(X"4C532F286") * Data_Type_Conversion1_out1;
  Gain2_out1 <= resize(Gain2_mul_temp(71 DOWNTO 51), 36);

  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_out1 <= Sum1_out1;
      END IF;
    END IF;
  END PROCESS Delay_process;


  Data_Type_Conversion1_out1 <= signed'(Modulator_output(0) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0');

  Gain1_mul_temp <= signed'(X"50451A854") * Data_Type_Conversion1_out1;
  Gain1_out1 <= resize(Gain1_mul_temp(71 DOWNTO 57), 36);

  Gain9_mul_temp <= to_signed(44569420, 36) * Delay1_out1;
  Gain9_out1 <= Gain9_mul_temp(70 DOWNTO 35);

  Sum_op_stage2 <= Gain_out1 - Gain9_out1;

  Sum_out1 <= Sum_op_stage2 - Gain1_out1;

  Gain14_mul_temp <= signed'(X"7FFFFFFFF") * Sum_out1;
  Gain14_out1 <= Gain14_mul_temp(70 DOWNTO 35);

  Sum1_add_temp <= Gain5_out1 + Gain14_out1;
  Sum1_out1 <= Sum1_add_temp + Delay_out1;

  Sum2_op_stage2 <= Gain6_out1 + Sum1_out1;

  Sum2_out1 <= Sum2_op_stage2 - Gain2_out1;

  Gain13_mul_temp <= signed'(X"7FFFFFFFF") * Sum2_out1;
  Gain13_out1 <= Gain13_mul_temp(70 DOWNTO 35);

  Sum3_out1 <= Gain13_out1 + Delay1_out1;

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay1_out1 <= Sum3_out1;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  Gain10_mul_temp <= to_signed(365531631, 36) * Delay3_out1;
  Gain10_out1 <= Gain10_mul_temp(70 DOWNTO 35);

  Sum4_op_stage2 <= Gain7_out1 - Gain10_out1;

  Sum4_op_stage3 <= Sum4_op_stage2 + Delay1_out1;

  Sum4_out1 <= Sum4_op_stage3 - Gain3_out1;

  Gain12_mul_temp <= signed'(X"7FFFFFFFF") * Sum4_out1;
  Gain12_out1 <= Gain12_mul_temp(70 DOWNTO 35);

  Sum5_out1 <= Gain12_out1 + Delay2_out1;

  Sum6_op_stage2 <= Gain8_out1 + Sum5_out1;

  Sum6_out1 <= Sum6_op_stage2 - Gain4_out1;

  Gain11_mul_temp <= signed'(X"7FFFFFFFF") * Sum6_out1;
  Gain11_out1 <= Gain11_mul_temp(70 DOWNTO 35);

  Sum7_out1 <= Gain11_out1 + Delay3_out1;

  Delay3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay3_out1 <= Sum7_out1;
      END IF;
    END IF;
  END PROCESS Delay3_process;


  Gain20_mul_temp <= to_signed(839029774, 36) * Delay5_out1;
  Gain20_out1 <= Gain20_mul_temp(70 DOWNTO 35);

  Sum8_op_stage2 <= Gain15_out1 - Gain20_out1;

  Sum8_op_stage3 <= Sum8_op_stage2 + Delay3_out1;

  Sum8_out1 <= Sum8_op_stage3 - Gain17_out1;

  Gain16_mul_temp <= signed'(X"7FFFFFFFF") * Sum8_out1;
  Gain16_out1 <= Gain16_mul_temp(70 DOWNTO 35);

  Sum9_out1 <= Gain16_out1 + Delay4_out1;

  Sum10_op_stage2 <= Gain18_out1 + Sum9_out1;

  Sum10_out1 <= Sum10_op_stage2 - Gain19_out1;

  Gain21_mul_temp <= signed'(X"7FFFFFFFF") * Sum10_out1;
  Gain21_out1 <= Gain21_mul_temp(70 DOWNTO 35);

  Sum11_out1 <= Gain21_out1 + Delay5_out1;

  Delay5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay5_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay5_out1 <= Sum11_out1;
      END IF;
    END IF;
  END PROCESS Delay5_process;


  Gain26_mul_temp <= to_signed(1217944013, 36) * Delay7_out1;
  Gain26_out1 <= Gain26_mul_temp(70 DOWNTO 35);

  Sum14_op_stage2 <= Gain28_out1 - Gain26_out1;

  Sum14_op_stage3 <= Sum14_op_stage2 + Delay5_out1;

  Sum14_out1 <= Sum14_op_stage3 - Gain23_out1;

  Gain22_mul_temp <= signed'(X"7FFFFFFFF") * Sum14_out1;
  Gain22_out1 <= Gain22_mul_temp(70 DOWNTO 35);

  Sum15_out1 <= Gain22_out1 + Delay6_out1;

  Sum12_op_stage2 <= Gain24_out1 + Sum15_out1;

  Sum12_out1 <= Sum12_op_stage2 - Gain25_out1;

  Gain27_mul_temp <= signed'(X"7FFFFFFFF") * Sum12_out1;
  Gain27_out1 <= Gain27_mul_temp(70 DOWNTO 35);

  Sum13_out1 <= Gain27_out1 + Delay7_out1;

  Delay7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay7_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay7_out1 <= Sum13_out1;
      END IF;
    END IF;
  END PROCESS Delay7_process;


  
  Modulator_output <= to_signed(1, 36) WHEN Delay7_out1 > to_signed(0, 36) ELSE
      to_signed(-1, 36) WHEN Delay7_out1 < to_signed(0, 36) ELSE
      to_signed(0, 36);

  Out1 <= std_logic_vector(Modulator_output);

  ce_out <= clk_enable;

END rtl;

