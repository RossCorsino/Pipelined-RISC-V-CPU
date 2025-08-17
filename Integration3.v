module LabN;
reg clk, INT;
wire[2:0] op;
reg [31:0] entryPoint;
wire[1:0] ALUop;
wire [31:0] wd, rd1, rd2, imm, ins, PCp4, z, memOut, wb, PCin;
wire [25:0] jTarget;
wire zero, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg, jump, branch, rtype, lw, sw;
wire [5:0] opCode;
wire [5:0] fnCode;

yIF myIF(ins, PCp4, PCin, clk);
yID myID(rd1, rd2, imm, jTarget, ins, wd, RegDst, RegWrite, clk);
yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc);
yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite);
yWB myWB(wb, z, memOut, Mem2Reg);
assign wd = wb;

yPC myPC(PCin, PCp4,INT,entryPoint,imm,jTarget,zero,branch,jump);
assign opCode = ins[31:26];
yC1 myC1(rtype, lw, sw, jump, branch, opCode);
yC2 myC2(RegDst, ALUSrc, RegWrite, Mem2Reg, MemRead, MemWrite,rtype, lw, sw, branch);
assign fnCode = ins[5:0];
yC3 myC3(ALUop, rtype, branch);
yC4 myC4(op, ALUop, fnCode);

initial
begin
	entryPoint = 128;
	INT = 1;
	#1;
	repeat(43)
	begin
		//Fetch instruction
		clk = 1; #1 INT = 0;
		//Execute instruction
		clk = 0;
		//View results
		#1;
		$display("%h: rd1=%2d rd2=%2d z=%3d zero=%1b wb=%2d", ins, rd1, rd2, z, zero, wb);
	end
end
endmodule
