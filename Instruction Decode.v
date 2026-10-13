

module decode(clk, rst, InstrD, PCD, PCPlus4D, RegWriteW, RDW, ResultW, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE,
    BranchE,JumpE,  ALUControlE, RD1_E, RD2_E, Imm_Ext_E, RD_E, PCE, PCPlus4E);

    // Declaring I/O
    input clk, rst, RegWriteW;
    input [4:0] RDW;
    input [31:0] InstrD, PCD, PCPlus4D, ResultW;

    output RegWriteE,ALUSrcE,MemWriteE,ResultSrcE,BranchE,JumpE;
    output [2:0] ALUControlE;
    output [31:0] RD1_E, RD2_E, Imm_Ext_E;
    output [4:0]  RD_E;
    output [31:0] PCE, PCPlus4E;

    wire [1:0] ImmSrcD;

    reg RegWriteD,ALUSrcD,MemWriteD,ResultSrcD,BranchD,JumpD;
    reg [2:0] ALUControlD;
    reg [31:0] RD1_D, RD2_D, Imm_Ext_D;
    reg [4:0] RD_D, RS1_D, RS2_D;
    reg [31:0] PCD, PCPlus4D;
    
    reg RegWriteE,ALUSrcE,MemWriteE,ResultSrcE,BranchE,JumpE;
    reg [2:0] ALUControlE;
    reg [31:0] RD1_E, RD2_E, Imm_Ext_E;
    reg [4:0]  RD_E;
    reg [31:0] PCE, PCPlus4E;

    // Initiate the modules
    // Control Unit
    Control_Unit_Top control (
                            .Op(InstrD[6:0]),
                            .RegWrite(RegWriteD),
                            .ImmSrc(ImmSrcD),
                            .ALUSrc(ALUSrcD),
                            .MemWrite(MemWriteD),
                            .ResultSrc(ResultSrcD),
                            .Branch(BranchD),
                            .Jump(JumpD)
                            .funct3(InstrD[14:12]),
                            .funct7(InstrD[31:25]),
                            .ALUControl(ALUControlD)
                            );

    // Register File
    Register_File rf (
                        .clk(clk),
                        .rst(rst),
                        .WE3(RegWriteW),
                        .WD3(ResultW),
                        .A1(InstrD[19:15]),
                        .A2(InstrD[24:20]),
                        .A3(RDW),
                        .RD1(RD1_D),
                        .RD2(RD2_D)
                        );

    // Sign Extension
     assign Imm_Ext =  (ImmSrcD == 2'b00) ? {{20{InstrD[31]}},InstrD[31:20]} :  (ImmSrcD == 2'b01) ? {{20{InstrD[31]}},InstrD[31:25],InstrD[11:7]} : 32'h00000000; 

    always @(posedge clk or negedge rst) begin
        if(rst) begin
            RegWriteE <= 1'b0;
            ALUSrcE <= 1'b0;
            MemWriteE <= 1'b0;
            ResultSrcE <= 1'b0;
            BranchE <= 1'b0;
            ALUControlE <= 3'b000;
            RD1_E <= 32'h00000000; 
            RD2_E <= 32'h00000000; 
            Imm_Ext_E <= 32'h00000000;
            RD_E <= 5'h00;
            PCE <= 32'h00000000; 
            PCPlus4E <= 32'h00000000;
        end
        else begin
            RegWriteE <= RegWriteD;
            ALUSrcE <= ALUSrcD;
            MemWriteE <= MemWriteD;
            ResultSrcE <= ResultSrcD;
            BranchE <= BranchD;
            ALUControlE <= ALUControlD;
            RD1_E <= RD1_D; 
            RD2_E <= RD2_D; 
            Imm_Ext_E <= Imm_Ext_D;
            RD_E <= InstrD[11:7];
            PCE <= PCD; 
            PCPlus4E <= PCPlus4D;
        end
    end
endmodule