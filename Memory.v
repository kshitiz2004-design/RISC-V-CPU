module memory(clk, rst, RegWriteM, MemWriteM, ResultSrcM, RD_M, PCPlus4M, WriteDataM, 
    ALU_ResultM, RegWriteW, ResultSrcW, RD_W, PCPlus4W, ALU_ResultW, ReadDataW);
    
    // Declaration of I/Os
    input clk, rst, RegWriteM, MemWriteM, ResultSrcM;
    input [4:0] RD_M; 
    input [31:0] PCPlus4M, WriteDataM, ALU_ResultM;

    output RegWriteW, ResultSrcW; 
    output [4:0] RD_W;
    output [31:0] PCPlus4W, ALU_ResultW, ReadDataW;

    // Declaration of Interim Wires
    wire [31:0] ReadDataM;

    // Declaration of Interim Registers
    reg RegWriteM, ResultSrcM;
    reg [4:0] RD_M;
    reg [31:0] PCPlus4M, ALU_ResultM, ReadDataM;

    reg RegWriteW, ResultSrcW;
    reg [4:0] RD_W;
    reg [31:0] PCPlus4W, ALU_ResultW, ReadDataW;

    // Declaration of Module Initiation
    Data_Memory dmem (
                        .clk(clk),
                        .rst(rst),
                        .WE(MemWriteM),
                        .WD(WriteDataM),
                        .A(ALU_ResultM),
                        .RD(ReadDataM)
                    );

    // Memory Stage Register Logic
    always @(posedge clk or negedge rst) begin
        if (rst ) begin
            RegWriteW <= 1'b0; 
            ResultSrcW <= 1'b0;
            RD_W <= 5'h00;
            PCPlus4W <= 32'h00000000; 
            ALU_ResultW <= 32'h00000000; 
            ReadDataW <= 32'h00000000;
        end
        else begin
            RegWriteW <= RegWriteM; 
            ResultSrcW <= ResultSrcM;
            RD_W <= RD_M;
            PCPlus4W <= PCPlus4M; 
            ALU_ResultW <= ALU_ResultM; 
            ReadDataW <= ReadDataM;
        end
    end 

endmodule
