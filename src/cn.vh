localparam [7:0] IL_KEY_ADDR = 8'h0  | 8'h40;
localparam [7:0] FL_KEY_ADDR = 8'h10 | 8'h40;
localparam [7:0] Z_ADDR = 8'h4;

localparam CFG_BITS = 4;
localparam CORE_ID_BITS = 6;
localparam ASIC_ID_BITS = 6;

localparam CFG_SPEEDUP_ML_LOG2 = 10;
localparam CFG_SPEEDUP_IL_LOG2 = 10;
localparam CORE_CFG_SPEEDUP_MODE = 1;
localparam CORE_CFG_SINGLE_STEP = 2;
