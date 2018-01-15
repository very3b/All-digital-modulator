function compile_hdl_design_top_fpga
% compile_hdl_design_top_fpga compiles HDL design
% Generated by Cosimulation Wizard
savedPath = getenv('PATH');
% Restore the PATH after compilation
restorePathObj = onCleanup(@()setenv('PATH', savedPath));
% Add HDL path
setenv('PATH', ['C:\Modeltech_pe_edu_10.4a\win32pe_edu;' getenv('PATH')])
[s, r] = system(['vsim < hdlverifier_compile_design.do'],'-echo');
if (s ~= 0)
    error(message('HDLLink:CosimWizard:CompilationError',r));
end

