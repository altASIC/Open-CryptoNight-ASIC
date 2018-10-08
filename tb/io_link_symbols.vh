// 9 bit symbol codes

localparam [8:0] symbol_idle      = 9'h100; // Channel idle
localparam [8:0] symbol_init      = 9'h101; // Initialize CN
localparam [8:0] symbol_start     = 9'h102; // Start CN running -- temporary
localparam [8:0] symbol_finished  = 9'h103; // CN signals finished with hash
localparam [8:0] symbol_SOF       = 9'h104; // Start of Frame
localparam [8:0] symbol_SOF_no_RX = 9'h105; // Start of Frame, do not read back buffer
localparam [8:0] symbol_EOF       = 9'h106; // End of Frame
