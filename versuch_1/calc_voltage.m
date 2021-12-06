function [voltage] = calc_voltage(adc_count,R_1,R_2)
%CALC_VOLTAGE Calculate Voltage

%% Voltage Divider
R=R_1+R_2;
voltage=double(adc_count)*R/R_2;
%% Final Conversion
voltage = (voltage/4096)*3;
end

%liebste rigatoni <3 