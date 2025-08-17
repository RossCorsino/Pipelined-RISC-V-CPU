module yMux1(z, a, b, c);
output z;
input a, b, c;
wire notC, upper, lower;
not my_not(notC, c);
and upperAnd(upper, a, notC);
and lowerAnd(lower, c, b);
or my_or(z, upper, lower);
endmodule
module yMux(z, a, b, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a, b;
input c;
yMux1 mine[SIZE-1:0](z, a, b, c);
endmodule
module yMux4to1(z, a0,a1,a2,a3, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a0, a1, a2, a3;
input [1:0] c;
wire [SIZE-1:0] zLo, zHi;
yMux #(SIZE) lo(zLo, a0, a1, c[0]);
yMux #(SIZE) hi(zHi, a2, a3, c[0]);
yMux #(SIZE) final(z, zLo, zHi, c[1]);
endmodule
module yAdder1(z, cout, a, b, cin);
output z, cout;
input a, b, cin;
xor left_xor(tmp, a, b);
xor right_xor(z, cin, tmp);
and left_and(outL, a, b);
and right_and(outR, tmp, cin);
or my_or(cout, outR, outL);
endmodule
module yAdder(z, cout, a, b, cin);
output [31:0] z;
output cout;
input [31:0] a, b;
input cin;
wire[31:0] in, out;
yAdder1 mine[31:0](z, out, a, b, in);
assign in[0] = cin;
assign in[31:1] = out[30:0];
assign cout = out[31];
endmodule
module yArith(z, cout, a, b, ctrl);
// add if ctrl=0, subtract if ctrl=1
output [31:0] z;
output cout;
input [31:0] a, b;
input ctrl;
wire[31:0] notB, tmp;
wire cin;
// instantiate the components and connect them
// Hint: about 4 lines of code
assign cin = ctrl;
not Not[31:0](notB, b);
yMux #(32) mux(tmp, b, notB, cin);
yAdder adder(z, cout, a ,tmp , cin);
endmodule
module yAlu(z, ex, a, b, op);
input [31:0] a, b;
input [2:0] op;
output [31:0] z;
output ex;
assign slt[31:1] = 0; // upper bits are always 0
// assign ex = 0; // need to comment out for LabL10 to work and obtain real value for ex
wire[31:0] andf, orf, adder1, adder2, slt;
wire[15:0] z16;
wire[7:0] z8;
wire[3:0] z4;
wire[1:0] z2;
wire z1, z0;

assign i = 1;

yArith #(32) sltarith(adder2, null, a, b, i);
xor #(1) xorr(condition, a[31], b[31]);
yMux #(1) sltmux(slt[0], adder2[31], a[31], condition);

or or16[15:0] (z16, z[15: 0], z[31:16]);
or or8[7:0] (z8, z16[7: 0], z16[15:8]);
or or4[3:0] (z4, z8[3: 0], z8[7:4]);
or or2[1:0] (z2, z4[1:0], z4[3:2]);
or or1[15:0] (z1, z2[1], z2[0]);
not nott(z0, z1);
assign ex = z0;

and andd[31:0] (andf, a, b);
or orr[31:0] (orf, a, b);
yArith #(32) arith(adder1, null, a, b, op[2]);
yMux4to1 #(32) mux(z, andf, orf, adder1, slt, op[1:0]);
endmodule

module yIF(ins, PCp4, PCin, clk);
output [31:0] ins, PCp4;
input [31:0] PCin;
input clk;
wire [31:0] PCout;
register #(32) pc(PCout, PCin, clk, 1'b1);
yAlu myAlu(PCp4, null, PCout, 32'd4, 3'b010);
mem myMem(ins, PCout, 32'b0, clk, 1'b1, 1'b0);
endmodule

module yID(rd1, rd2, imm, jTarget, ins, wd, RegDst, RegWrite, clk);
output[31:0] rd1, rd2, imm;
output[25:0] jTarget;
input[31:0]  ins, wd;
input RegDst, RegWrite, clk;
wire[4:0] rn1, rn2, wn;
wire[15:0] zeros, ones;
assign zeros[15:0] = 16'b0000000000000000;
assign ones[15:0] = 16'b1111111111111111;

assign rn1 = ins[25:21];
assign rn2 = ins[20:16];
yMux #(5) mux(wn, rn2, ins[15:11], RegDst);

assign imm[15:0] = ins[15:0];
assign jTarget = ins[25:0];

yMux #(16) se(imm[31:16], zeros, ones, ins[15]);

rf regfile(rd1, rd2, rn1, rn2, wn, wd, clk, RegWrite);
endmodule

module yEX(z, zero, rd1, rd2, imm, op, ALUSrc);
output[31:0] z;
output zero;
input[31:0]  rd1, rd2, imm;
input[2:0] op;
input ALUSrc;
wire[31:0] b;

yMux #(32) mux(b, rd2, imm, ALUSrc);
yAlu alu(z, zero, rd1, b, op);
endmodule

module yDM(memOut, exeOut, rd2, clk, MemRead, MemWrite);
output [31:0] memOut;
input [31:0] exeOut, rd2;
input clk, MemRead, MemWrite;
mem memory(memOut, exeOut, rd2, clk, MemRead, MemWrite);
endmodule

module yWB(wb, exeOut, memOut, Mem2Reg);
output [31:0] wb;
input [31:0] exeOut, memOut;
input Mem2Reg;
yMux #(32) mux(wb, exeOut, memOut, Mem2Reg);
endmodule
