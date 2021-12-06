function [current] = calc_current(adc_count,R_clg_1,R_clg_2,R_ref)
%CALC_VOLTAGE Calculating current
%   Current is measured using a shunt R_ref. The voltage is amplified with
%   a non-inverting amplifier. R_clg_1 & R_clg_2 are the closed-loop resistors.
gain=(R_clg_1 + R_clg_2)/R_clg_1;
current =(3*(double(adc_count)/4096)/gain)/R_ref;
end


