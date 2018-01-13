-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\DSM_MOD8_HDL\Quantizer.vhd
-- Created: 2018-01-08 05:56:34
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Quantizer
-- Source Path: DSM_MOD8_HDL/Eight_order_delta_sigma_modulator/Quantizer
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Quantizer IS
  PORT( u                                 :   IN    std_logic_vector(35 DOWNTO 0);  -- sfix36_En32
        y                                 :   OUT   std_logic_vector(35 DOWNTO 0)  -- sfix36_En32
        );
END Quantizer;


ARCHITECTURE rtl OF Quantizer IS

  -- Signals
  SIGNAL u_signed                         : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL y_tmp                            : signed(35 DOWNTO 0);  -- sfix36_En32

BEGIN
  u_signed <= signed(u);

  
  y_tmp <= signed'(X"F00000000") WHEN u_signed < to_signed(0, 36) ELSE
      signed'(X"100000000");

  y <= std_logic_vector(y_tmp);

END rtl;

