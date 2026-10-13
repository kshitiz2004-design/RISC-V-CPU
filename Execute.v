module execute(clk, rst, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE,JumpE, ALUControlE, 
    RD1_E, RD2_E, Imm_Ext_E, RD_E, PCE, PCPlus4E, PCSrcE, PCTargetE, RegWriteM, MemWriteM, ResultSrcM, RD_M, PCPlus4M, WriteDataM, ALU_ResultM, ResultW, ForwardA_E, ForwardB_E);

    // Declaration I/Os
    input clk, rst, RegWriteE,ALUSrcE,MemWriteE,ResultSrcE,BranchE,JumpE;
    input [2:0] ALUControlE;
    input [31:0] RD1_E, RD2_E, Imm_Ext_E;
    input [4:0] RD_E;
    input [31:0] PCE, PCPlus4E;

    output PCSrcE, RegWriteM, MemWriteM, ResultSrcM;
    output [4:0] RD_M; 
    output [31:0] PCPlus4M, WriteDataM, ALU_ResultM;
    output [31:0] PCTargetE;

    // Declaration of Interim Wires
    wire [31:0] Src_BE;
    wire [31:0] ResultE;
    wire ZeroE,PCSrcE_A;

    // Declaration of Register
    reg RegWriteE, MemWriteE, ResultSrcE;
    reg [4:0] RD_E;
    reg [31:0] PCPlus4E, RD2_E, ResultE;

    reg RegWriteM, MemWriteM, ResultSrcM;
    reg [4:0] RD_M;
    reg [31:0] PCPlus4M, RD2_M, ResultM;

    // Declaration of Modules
    // ALU Src Mux
            Src_BE=ALUSrcE?Imm_Ext_E:RD2_E;

    // ALU Unit
    ALU alu (
            .A(RD1_E),
            .B(Src_BE),
            .Result(ResultE),
            .ALUControl(ALUControlE),
            .OverFlow(),
            .Carry(),
            .Zero(ZeroE),
            .Negative()
            );

    // Adder
            assign PCTargetE=PCE+Imm_Ext_E;

    // Register Logic
    always @(posedge clk or negedge rst) begin
        if(rst) begin
            RegWriteM <= 1'b0; 
            MemWriteM <= 1'b0; 
            ResultSrcM <= 1'b0;
            RD_M <= 5'h00;
            PCPlus4M <= 32'h00000000; 
            RD2_M <= 32'h00000000; 
            ALU_ResultM <= 32'h00000000;
        end
        else begin
            RegWriteM <= RegWriteE; 
            MemWriteM <= MemWriteE; 
            ResultSrcM <= ResultSrcE;
            RD_M <= RD_E;
            PCPlus4M <= PCPlus4E; 
            RD2_M <= RD2_E; 
            ALU_ResultM <= ResultE;
        end
    end

    // Output Assignments
    assign PCSrcE_A = ZeroE &  BranchE;
    assign PCSrcE=PCSrcE_A | JumpE;

endmodule