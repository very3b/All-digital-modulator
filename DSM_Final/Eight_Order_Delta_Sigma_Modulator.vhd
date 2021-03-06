-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\DSM_MOD8_HDL\Eight_order_delta_sigma_modulator.vhd
-- Created: 2018-01-08 05:56:34
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
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
-- Module: Eight_order_delta_sigma_modulator
-- Source Path: DSM_MOD8_HDL/Eight_order_delta_sigma_modulator
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.Eight_order_delta_sigma_modulator_pkg.ALL;

ENTITY Eight_order_delta_sigma_modulator IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        In1                               :   IN    std_logic_vector(35 DOWNTO 0);  -- sfix36_En32
        ce_out                            :   OUT   std_logic;
        Out1                              :   OUT   std_logic_vector(1 DOWNTO 0)  -- sfix2
        );
END Eight_order_delta_sigma_modulator;


ARCHITECTURE rtl OF Eight_order_delta_sigma_modulator IS

  -- Component Declarations
  COMPONENT Quantizer
    PORT( u                               :   IN    std_logic_vector(35 DOWNTO 0);  -- sfix36_En32
          y                               :   OUT   std_logic_vector(35 DOWNTO 0)  -- sfix36_En32
          );
  END COMPONENT;

  COMPONENT Sign
    PORT( u                               :   IN    std_logic_vector(35 DOWNTO 0);  -- sfix36_En32
          y                               :   OUT   std_logic_vector(1 DOWNTO 0)  -- sfix2
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Quantizer
    USE ENTITY work.Quantizer(rtl);

  FOR ALL : Sign
    USE ENTITY work.Sign(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL In1_signed                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Digital_PCM_signal               : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain24_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL delayMatch7_reg                  : vector_of_signed36(0 TO 5);  -- sfix36 [6]
  SIGNAL Gain24_out1_1                    : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain28_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL delayMatch6_reg                  : vector_of_signed36(0 TO 5);  -- sfix36 [6]
  SIGNAL Gain28_out1_1                    : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain18_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL delayMatch5_reg                  : vector_of_signed36(0 TO 5);  -- sfix36 [6]
  SIGNAL Gain18_out1_1                    : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain15_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL delayMatch4_reg                  : vector_of_signed36(0 TO 5);  -- sfix36 [6]
  SIGNAL Gain15_out1_1                    : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain8_out1                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL delayMatch3_reg                  : vector_of_signed36(0 TO 5);  -- sfix36 [6]
  SIGNAL Gain8_out1_1                     : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain7_out1                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL delayMatch2_reg                  : vector_of_signed36(0 TO 5);  -- sfix36 [6]
  SIGNAL Gain7_out1_1                     : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain6_out1                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL delayMatch1_reg                  : vector_of_signed36(0 TO 5);  -- sfix36 [6]
  SIGNAL Gain6_out1_1                     : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain5_out1                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL delayMatch_reg                   : vector_of_signed36(0 TO 5);  -- sfix36 [6]
  SIGNAL Gain5_out1_1                     : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL kconst                           : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL kconst_1                         : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Digital_PCM_signal_1             : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain_mul_temp                    : signed(71 DOWNTO 0);  -- sfix72_En64
  SIGNAL Gain_out1                        : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL PipelineRegister_reg             : vector_of_signed36(0 TO 4);  -- sfix36 [5]
  SIGNAL Gain_out1_1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL y_signed                         : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain25_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En67
  SIGNAL Gain25_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain23_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En69
  SIGNAL Gain23_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain19_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En71
  SIGNAL Gain19_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain17_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En74
  SIGNAL Gain17_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain4_mul_temp                   : signed(71 DOWNTO 0);  -- sfix72_En76
  SIGNAL Gain4_out1                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain3_mul_temp                   : signed(71 DOWNTO 0);  -- sfix72_En81
  SIGNAL Gain3_out1                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain2_mul_temp                   : signed(71 DOWNTO 0);  -- sfix72_En83
  SIGNAL Gain2_out1                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL y                                : std_logic_vector(35 DOWNTO 0);  -- ufix36
  SIGNAL Gain1_mul_temp                   : signed(71 DOWNTO 0);  -- sfix72_En89
  SIGNAL Gain1_out1                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Delay1_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain9_mul_temp                   : signed(71 DOWNTO 0);  -- sfix72_En64
  SIGNAL Gain9_out1                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum_op_stage2                    : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum_out1                         : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Delay_out1                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum1_add_temp                    : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum1_out1                        : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum2_op_stage2                   : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum2_out1                        : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum3_out1                        : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Delay3_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain10_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En64
  SIGNAL Gain10_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum4_op_stage2                   : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum4_op_stage3                   : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum4_out1                        : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Delay2_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum5_out1                        : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum6_op_stage2                   : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum6_out1                        : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum7_out1                        : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Delay5_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain20_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En64
  SIGNAL Gain20_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum8_op_stage2                   : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum8_op_stage3                   : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum8_out1                        : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Delay4_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum9_out1                        : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum10_op_stage2                  : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum10_out1                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum11_out1                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Delay7_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Gain26_mul_temp                  : signed(71 DOWNTO 0);  -- sfix72_En64
  SIGNAL Gain26_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum14_op_stage2                  : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum14_op_stage3                  : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum14_out1                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Delay6_out1                      : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum15_out1                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum12_op_stage2                  : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum12_out1                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL Sum13_out1                       : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL y_1                              : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL y_2                              : signed(35 DOWNTO 0);  -- sfix36_En32

BEGIN
  u_Quantizer : Quantizer
    PORT MAP( u => std_logic_vector(Delay7_out1),  -- sfix36_En32
              y => y  -- sfix36_En32
              );

  u_Sign : Sign
    PORT MAP( u => y,  -- sfix36_En32
              y => y_1  -- sfix2
              );

  In1_signed <= signed(In1);

  Digital_PCM_signal <= In1_signed;

  Gain24_out1 <= to_signed(0, 36);

  enb <= clk_enable;

  delayMatch7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch7_reg <= (OTHERS => to_signed(0, 36));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch7_reg(0) <= Gain24_out1;
        delayMatch7_reg(1 TO 5) <= delayMatch7_reg(0 TO 4);
      END IF;
    END IF;
  END PROCESS delayMatch7_process;

  Gain24_out1_1 <= delayMatch7_reg(5);

  Gain28_out1 <= to_signed(0, 36);

  delayMatch6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch6_reg <= (OTHERS => to_signed(0, 36));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch6_reg(0) <= Gain28_out1;
        delayMatch6_reg(1 TO 5) <= delayMatch6_reg(0 TO 4);
      END IF;
    END IF;
  END PROCESS delayMatch6_process;

  Gain28_out1_1 <= delayMatch6_reg(5);

  Gain18_out1 <= to_signed(0, 36);

  delayMatch5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch5_reg <= (OTHERS => to_signed(0, 36));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch5_reg(0) <= Gain18_out1;
        delayMatch5_reg(1 TO 5) <= delayMatch5_reg(0 TO 4);
      END IF;
    END IF;
  END PROCESS delayMatch5_process;

  Gain18_out1_1 <= delayMatch5_reg(5);

  Gain15_out1 <= to_signed(0, 36);

  delayMatch4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch4_reg <= (OTHERS => to_signed(0, 36));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch4_reg(0) <= Gain15_out1;
        delayMatch4_reg(1 TO 5) <= delayMatch4_reg(0 TO 4);
      END IF;
    END IF;
  END PROCESS delayMatch4_process;

  Gain15_out1_1 <= delayMatch4_reg(5);

  Gain8_out1 <= to_signed(0, 36);

  delayMatch3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch3_reg <= (OTHERS => to_signed(0, 36));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch3_reg(0) <= Gain8_out1;
        delayMatch3_reg(1 TO 5) <= delayMatch3_reg(0 TO 4);
      END IF;
    END IF;
  END PROCESS delayMatch3_process;

  Gain8_out1_1 <= delayMatch3_reg(5);

  Gain7_out1 <= to_signed(0, 36);

  delayMatch2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch2_reg <= (OTHERS => to_signed(0, 36));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch2_reg(0) <= Gain7_out1;
        delayMatch2_reg(1 TO 5) <= delayMatch2_reg(0 TO 4);
      END IF;
    END IF;
  END PROCESS delayMatch2_process;

  Gain7_out1_1 <= delayMatch2_reg(5);

  Gain6_out1 <= to_signed(0, 36);

  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch1_reg <= (OTHERS => to_signed(0, 36));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch1_reg(0) <= Gain6_out1;
        delayMatch1_reg(1 TO 5) <= delayMatch1_reg(0 TO 4);
      END IF;
    END IF;
  END PROCESS delayMatch1_process;

  Gain6_out1_1 <= delayMatch1_reg(5);

  Gain5_out1 <= to_signed(0, 36);

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch_reg <= (OTHERS => to_signed(0, 36));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch_reg(0) <= Gain5_out1;
        delayMatch_reg(1 TO 5) <= delayMatch_reg(0 TO 4);
      END IF;
    END IF;
  END PROCESS delayMatch_process;

  Gain5_out1_1 <= delayMatch_reg(5);

  kconst <= to_signed(642, 36);

  HwModeRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      kconst_1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        kconst_1 <= kconst;
      END IF;
    END IF;
  END PROCESS HwModeRegister_process;


  HwModeRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Digital_PCM_signal_1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Digital_PCM_signal_1 <= Digital_PCM_signal;
      END IF;
    END IF;
  END PROCESS HwModeRegister1_process;


  Gain_mul_temp <= kconst_1 * Digital_PCM_signal_1;
  Gain_out1 <= Gain_mul_temp(67 DOWNTO 32);

  PipelineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      PipelineRegister_reg <= (OTHERS => to_signed(0, 36));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        PipelineRegister_reg(0) <= Gain_out1;
        PipelineRegister_reg(1 TO 4) <= PipelineRegister_reg(0 TO 3);
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;

  Gain_out1_1 <= PipelineRegister_reg(4);

  Gain25_mul_temp <= signed'(X"491FC4622") * y_signed;
  Gain25_out1 <= Gain25_mul_temp(70 DOWNTO 35);

  Gain23_mul_temp <= signed'(X"67B091812") * y_signed;
  Gain23_out1 <= resize(Gain23_mul_temp(71 DOWNTO 37), 36);

  Gain19_mul_temp <= signed'(X"5BBD4B283") * y_signed;
  Gain19_out1 <= resize(Gain19_mul_temp(71 DOWNTO 39), 36);

  Gain17_mul_temp <= signed'(X"4BF3D56B3") * y_signed;
  Gain17_out1 <= resize(Gain17_mul_temp(71 DOWNTO 42), 36);

  Gain4_mul_temp <= signed'(X"45E224032") * y_signed;
  Gain4_out1 <= resize(Gain4_mul_temp(71 DOWNTO 44), 36);

  Gain3_mul_temp <= signed'(X"6F7E38958") * y_signed;
  Gain3_out1 <= resize(Gain3_mul_temp(71 DOWNTO 49), 36);

  Gain2_mul_temp <= signed'(X"4C532F286") * y_signed;
  Gain2_out1 <= resize(Gain2_mul_temp(71 DOWNTO 51), 36);

  y_signed <= signed(y);

  Gain1_mul_temp <= signed'(X"50451A854") * y_signed;
  Gain1_out1 <= resize(Gain1_mul_temp(71 DOWNTO 57), 36);

  Gain9_mul_temp <= to_signed(5571177, 36) * Delay1_out1;
  Gain9_out1 <= Gain9_mul_temp(67 DOWNTO 32);

  Sum_op_stage2 <= Gain_out1_1 - Gain9_out1;

  Sum_out1 <= Sum_op_stage2 - Gain1_out1;

  Sum1_add_temp <= Gain5_out1_1 + Sum_out1;
  Sum1_out1 <= Sum1_add_temp + Delay_out1;

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


  Sum2_op_stage2 <= Gain6_out1_1 + Delay_out1;

  Sum2_out1 <= Sum2_op_stage2 - Gain2_out1;

  Sum3_out1 <= Sum2_out1 + Delay1_out1;

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


  Gain10_mul_temp <= to_signed(45691454, 36) * Delay3_out1;
  Gain10_out1 <= Gain10_mul_temp(67 DOWNTO 32);

  Sum4_op_stage2 <= Gain7_out1_1 - Gain10_out1;

  Sum4_op_stage3 <= Sum4_op_stage2 + Delay1_out1;

  Sum4_out1 <= Sum4_op_stage3 - Gain3_out1;

  Sum5_out1 <= Sum4_out1 + Delay2_out1;

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


  Sum6_op_stage2 <= Gain8_out1_1 + Delay2_out1;

  Sum6_out1 <= Sum6_op_stage2 - Gain4_out1;

  Sum7_out1 <= Sum6_out1 + Delay3_out1;

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


  Gain20_mul_temp <= to_signed(104878722, 36) * Delay5_out1;
  Gain20_out1 <= Gain20_mul_temp(67 DOWNTO 32);

  Sum8_op_stage2 <= Gain15_out1_1 - Gain20_out1;

  Sum8_op_stage3 <= Sum8_op_stage2 + Delay3_out1;

  Sum8_out1 <= Sum8_op_stage3 - Gain17_out1;

  Sum9_out1 <= Sum8_out1 + Delay4_out1;

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


  Sum10_op_stage2 <= Gain18_out1_1 + Delay4_out1;

  Sum10_out1 <= Sum10_op_stage2 - Gain19_out1;

  Sum11_out1 <= Sum10_out1 + Delay5_out1;

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


  Gain26_mul_temp <= to_signed(152243002, 36) * Delay7_out1;
  Gain26_out1 <= Gain26_mul_temp(67 DOWNTO 32);

  Sum14_op_stage2 <= Gain28_out1_1 - Gain26_out1;

  Sum14_op_stage3 <= Sum14_op_stage2 + Delay5_out1;

  Sum14_out1 <= Sum14_op_stage3 - Gain23_out1;

  Sum15_out1 <= Sum14_out1 + Delay6_out1;

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


  Sum12_op_stage2 <= Gain24_out1_1 + Delay6_out1;

  Sum12_out1 <= Sum12_op_stage2 - Gain25_out1;

  Sum13_out1 <= Sum12_out1 + Delay7_out1;

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


  ce_out <= clk_enable;

  Out1 <= y_1;

END rtl;

