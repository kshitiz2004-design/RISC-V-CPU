module fetch(clk, rst, PCSrcE, PCTargetE, InstrD, PCD, PCPlus4D);

    // Declare input & outputs
    input clk, rst;
    input PCSrcE;
    input [31:0] PCTargetE;
    output [31:0] InstrD;
    output [31:0] PCD, PCPlus4D;

    // Declaring interim wires
    wire [31:0] PC_F;

    // Declaration of Register
    reg [31:0] InstrF;
    reg [31:0] PCF, PCPlus4F;

    PC_F=PCSrcE?PCTargetE:PCPlus4F; //mux//

    // Declare PC Counter
    always@(posedge clk)
    begin
    if (rst)
         PCF <= {32{1'b0}};
        else
            PCF <= PC_F;
        end

    // Declare Instruction Memory
    Instruction_Memory IMEM (
                .rst(rst),
                .A(PCF),
                .RD(InstrF)
                );

    // Declare PC adder
                assign PCPlus4F= PCF+32'h00000004;

    // Assigning Registers Value to the Output port
    assign  InstrD = (rst) ? 32'h00000000 : InstrF;
    assign  PCD = (rst ) ? 32'h00000000 : PCF;
    assign  PCPlus4D = (rst ) ? 32'h00000000 : PCPlus4F;

endmodule