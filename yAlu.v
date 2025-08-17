module yAlu(z, ex, a, b, op);
input [31:0] a, b;
input [2:0] op;
output [31:0] z;
output ex;
assign slt[31:1] = 0; // upper bits are always 0
assign ex = 0; // need to comment out for LabL10 to work and obtain defined value for ex
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
